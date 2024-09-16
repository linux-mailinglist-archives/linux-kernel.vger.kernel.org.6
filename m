Return-Path: <linux-kernel+bounces-330439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDF4979E95
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B531C22E14
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11114A4C1;
	Mon, 16 Sep 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt3OgTZE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F650284;
	Mon, 16 Sep 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479699; cv=none; b=XPUGIVPXtgb2wAseySh9KxtN9dTWJIIVAHkaZSmyl6F8x37UVH8+++HwsKAUqIVkBs1ahOhwQ0/YVupf3fRHMprMxXwr0PN68d/oVT1yJdrtyVRtlNwgooZsyJa6PF8IF3dJUE5UGf2/XxQNHaOhil0TSmwMiV4Xx82pDvMa++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479699; c=relaxed/simple;
	bh=ZreA9/HkQ19nX8Nid+x7G27Z9GlPOZY3UgUMemLERXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcthGzn+ZaG2tnbey+zv6YCEBQlomb+3r685nJEHXN6HRxmq9JGIzK5zkjGjHjk/r7pceH0nWNcZLe7GDlO6JtHxlNaKaBbe0fjG+MPvaWCmJOtQrDnwcyqaDa/QuWxGswcGbIW3oz6J4QkVfpRr32Pi7GIjqa0uSTWFKZisjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt3OgTZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B75C4CEC4;
	Mon, 16 Sep 2024 09:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726479698;
	bh=ZreA9/HkQ19nX8Nid+x7G27Z9GlPOZY3UgUMemLERXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mt3OgTZEmz4P+RQTuoAnnr1Fe0y1u8PkRvx1TlYb/aNRg1m/exKbENsy3Ckq8WvDM
	 tDYcEpTyWNS7gEqR383vYhwUH7ngGaSq76oRbwg5MgBfQ6RO+zuBTEu9oECAMi0KcJ
	 fM9fzuFE8qEWTAzSw7V9KV5LdTrUf9B3GnstwCRnZmRCh+fHcGfTdfiBEJDP+GM4S3
	 1jmVjUHlAEKUlr3pQcJtP0ilm9PFZLCmJj4Xg7/rdVW7XVUoV/lcw1/pjz8gGxx69q
	 8+B5FEBegtIaENA+GfouUFAjo7GQPXBUUO/urX4fNqoo/VMIHBP0aHIrPmALWMkDHK
	 VgyUDsM3HiPJQ==
Date: Mon, 16 Sep 2024 11:41:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Liu Ying <victor.liu@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: reset: add schema for imx8ulp SIM
 reset
Message-ID: <dmfqq6osoaun34dasbdzhzf4sj6t3npx6ujzhuu73227qhc4hq@rd2skytkm2dh>
References: <20240915114311.75496-1-laurentiu.mihalcea@nxp.com>
 <20240915114311.75496-2-laurentiu.mihalcea@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240915114311.75496-2-laurentiu.mihalcea@nxp.com>

On Sun, Sep 15, 2024 at 07:43:09AM -0400, Laurentiu Mihalcea wrote:
> Add schema for imx8ulp's SIM reset controller.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Fix checkpatch errors. You have SoB mismatch.

This applies to all your patches.

Best regards,
Krzysztof


