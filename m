Return-Path: <linux-kernel+bounces-516597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938C5A3746F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E413A80CA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B918FC80;
	Sun, 16 Feb 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9fTKODF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476361624E7;
	Sun, 16 Feb 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739711068; cv=none; b=n2WbKpK/D1qB6yQ2+G84DvWyhkXTscj7J7bhvYZGJkkLlPIDE37NvLxRHKh9lKIpR1TLGMT5DtvvWFPTHqdABu0I/Nfepknx/EBeZUafksvbZIPD/VdG+F5pZrOCr+9xhUGucyCqpI0TjDGcrx0sgzMZeaSZPY7hQx/FWj0pHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739711068; c=relaxed/simple;
	bh=2DgYYa+sRMSdsArcKlMHioO3e8x9CH+o+ntTlFbukHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOfqNInrIblcQhvYP93rOSHzwBHBXl3n81FtCntrwalP9yYrgeJWRAietotuTIlqLb0QSErQxDmEFs1ecNw3/bXnyvXk3W5Vo6APlWg3Ou5LXnyi9aPeS2Zv4GCTpGoN+wxu83Sd+X5F3slQnJRDVZbqNDK4bZb2adj5PpI4tEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9fTKODF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5CDC4CEDD;
	Sun, 16 Feb 2025 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739711067;
	bh=2DgYYa+sRMSdsArcKlMHioO3e8x9CH+o+ntTlFbukHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9fTKODFfoifPnR9RwfctjqijIXwhq8ui6ZqPyQbbqdk/EEVTh5BLH9Zj0YCsso9Q
	 KF17nj5EnIBNcXLEcWiIMDUOGC2T9Sujm0Ah329jNbGdd8FdsM3r/uVxcuotmo6iNG
	 pTto3kLPJq+BEvl38RYwKHglkijlPQNFv5z1ngsnnAh9LNt18jYX2J2idV09efplBe
	 1fSHQVJqpP7S5AqzxU+94N06F3/KGHz8ix6Ck0j2L4CHFmyPjTXbQMVPQr+m8U7AOr
	 q1ZJ1HBXbEBgdvPTfPkEatYreGFNSv7GKhBfgHyAYKMPuNMCKGoSMThr1zNHaKBKxw
	 mVPIp4EIRkbFg==
Date: Sun, 16 Feb 2025 14:04:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nikola Jelic <nikola.jelic83@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, 
	tiwai@suse.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rwalton@cmlmicro.com
Subject: Re: [PATCH 2/2 V5] ASoC: codecs: cmx655: Add CML's CMX655D codec
Message-ID: <20250216-nano-pelican-of-holiness-23b1fb@krzk-bin>
References: <20250214215826.80878-1-nikola.jelic83@gmail.com>
 <20250214215826.80878-2-nikola.jelic83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214215826.80878-2-nikola.jelic83@gmail.com>

On Fri, Feb 14, 2025 at 10:58:02PM +0100, Nikola Jelic wrote:
> Signed-off-by: Nikola Jelic <nikola.jelic83@gmail.com>
> 
> ---
> V4 -> V5: Introduced a module parameter for reset attempts, header fixes

Why this is v5 but other patch is v4?

Entire patchset is versioned, not patches. `b4` does it for you. `git
format-patch -v4` as well.

Best regards,
Krzysztof


