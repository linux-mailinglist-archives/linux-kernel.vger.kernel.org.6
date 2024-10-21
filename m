Return-Path: <linux-kernel+bounces-373752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA40F9A5C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 625A8B229AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CE81D12F9;
	Mon, 21 Oct 2024 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9q2qIHa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43D1D12E0;
	Mon, 21 Oct 2024 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494317; cv=none; b=Ez6ssd5KDDsadoCWQe9+jiAYPwZXP+Sj7Vkm3n/7opwqAojuoUaapkFh4zmdRgYcKXD4wHx+UEaotlQP0s2PTNbhH8i61fIJp4FKgGI/jMNUvC929C5TiCKv92U4Nxx/kGeuFYPcPMcgqtRbhGrS3XyOIlXON5AQsIHeLT9Mzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494317; c=relaxed/simple;
	bh=3g7Tez+RiNPqSUOGyTVqp0F801z/l8ZXIYh+Z3kz28Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ojlh7+Dn4NREj6ZqFn4V+0sEny/hgfMuN7JNw787kUG1SO48CQkLkddL5WVGme/03TlawCFuZ7tR+kr0GAUfBNtamQYjxkxZC7U3SYSCw/FbQGM9UzcJ1UJQfSKgL3jMLZR58hOpPFzFrlQD/XlabWlIJnCjJrCPnjt5hz/fGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9q2qIHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD5CC4CEC3;
	Mon, 21 Oct 2024 07:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729494316;
	bh=3g7Tez+RiNPqSUOGyTVqp0F801z/l8ZXIYh+Z3kz28Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9q2qIHa3EZRBE9I43KMgsTqbbtq3B1QBv0aGTtIImCAAesLsO16rvtIPh0MiXPjM
	 pmPNDPblrxRzb1tU49iGteixxz/gHpwXcfcZ5hFvd8AumLMFU+Q6fvkH16jFvV1UKp
	 Vqy0Q2rHPkfFsAyR0rl1wzXYsvgR7nUT0wTOmbnIQzlEdy4kTZ+Cuav/uuvZU2erJR
	 uXgTgSLrWSjsqeR5ikPiexn06GfvdfjVFAMw4spV1R+DoczlFTar8cW6RE+7jnguPP
	 rqMuPuqog3Xwb3PGXQFAC3+jJerDqSJprsccPom+HrCUNYU/mqpv6v7hWX+EKNUDtm
	 LWUxZSlzg/MZA==
Date: Mon, 21 Oct 2024 09:05:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 11/23] ARM: socfpga: dts: add compatibility for arria10
Message-ID: <aogtpcasb4ge5uggdhchk62cvspo74rflwealjgqekqbpdcndw@yt7wjokfy6ag>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
 <20241020194028.2272371-12-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020194028.2272371-12-l.rubusch@gmail.com>

On Sun, Oct 20, 2024 at 07:40:16PM +0000, Lothar Rubusch wrote:
> Add compatibility to the arria10 platform. This fixes the dtschema issue
> 'dwmac: failed to match any schema with compatible'.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Best regards,
Krzysztof


