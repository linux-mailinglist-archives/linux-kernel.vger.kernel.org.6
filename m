Return-Path: <linux-kernel+bounces-271376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73897944D5E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746FA1C21DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB781A3BC3;
	Thu,  1 Aug 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpfNMcWL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4961FF2;
	Thu,  1 Aug 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519841; cv=none; b=BUo3Ma8y0Mh/x17cB38yZnv513+LGNdkZILzCKyOm/Oqbbx1Bu92cD95a1EwQ7yIrBWE4S+qXbKkbR4XxnxFXgxPxr44Lxm3NXsRZrNyNzghpHLmtw4mDlbzSeuFxGAzbBWLiWmxPL2RnAH3jBw8B9JTNIp8pOMooEiNgFv6o7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519841; c=relaxed/simple;
	bh=gur3oPnm0+eAY3YGNOkvdwa7WcbwAtDFqPcj0mJBa7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0977IYRXAEGf7xdbgEOZpV6HYGJuAqwncz+I1J+evuHMLFdqJewtaaByt+/f63PB1LyOFCtp0JeIugcsPR6jDXJB271W6k0GhxPUp2hCOJ4vmcmFKYM7U3GqDHuc9s5YoSO7L3c8jhws5Uy8nItXZ3rWIAl8VvJ/T3XVRrY4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpfNMcWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B3AC32786;
	Thu,  1 Aug 2024 13:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722519841;
	bh=gur3oPnm0+eAY3YGNOkvdwa7WcbwAtDFqPcj0mJBa7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpfNMcWLpTjSeao8SVBDmvNWmUQs98RqiSX40I+A1KgSXECTJmxRY+ORKucJsk2qM
	 vBiS/i/uw4gxF5E9kLRiGo00nWozIbdqT5UJe23nj8qu6WCLY/9sSZsUS2u7kLT41N
	 q42lm9J0S5KGb4Vhf0xwiSzYX+k1JggTWA7rZI1wPhPLaP+RfwE893GAaYWkFmit59
	 i8z1YEwWE/eECRutyzfHqaOi6XqlsyYUSXVBR3baK6/PKVpOczrrPXnvP8jSouhrHm
	 xjYTg3zeuTDTk03Xv+miYz2PiWI6EFe6PnJzl0gM2d6j5Dvm3Gwx14atOzQXvUQUFO
	 C0WOogckV1CmA==
Date: Thu, 1 Aug 2024 15:43:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: clean up warnings for multigrain
 timestamp docs
Message-ID: <20240801-reinschauen-kurstadt-3ef10c0ec0e4@brauner>
References: <20240801105127.25048-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801105127.25048-1-jlayton@kernel.org>

> Christian,
> 
> It may be best to fold this patch into f9cb86069bad (Documentation: add a
> new file documenting multigrain timestamps)

Done, thanks!

