Return-Path: <linux-kernel+bounces-276672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF06A9496D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A8B27454
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1C27EEFD;
	Tue,  6 Aug 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYWM92kE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FD4A2C;
	Tue,  6 Aug 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965392; cv=none; b=uVinXwDnvG369Lhu2o7Ydg2wkKfRlZ+OA33XD1mDB3P5l2b7R007vNn151+kGe4SeRhXdB7lyvH9J98HzwNvQLa5HRyA5qfvRMAMpbkCFDjDhQ0u0ELwl8at8DhA2Yji/766OCl7VPv4+c+pOiYTol9OILaxiFR6Kg1blJS4tII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965392; c=relaxed/simple;
	bh=BohhubMTTw5v5kSSxdRoq7WgGUyBqQmZwKjXUm3QElE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rc8HQXNo9HvBr2BOhRatiMq/de7FWiOAuRaK4hBZRReHOvnloLun1TDlCHKvv/pey3pWq24IQ3QVA+IZ6a8f1s8kOwyLNzY/h3/V2qqUm/CYxRWUuk4wC66pglbORCt8MSfFUrBSK+rEoD5YAztNQr0C8PHFwq4ubaWVm8Hj8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYWM92kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CFFC32786;
	Tue,  6 Aug 2024 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722965391;
	bh=BohhubMTTw5v5kSSxdRoq7WgGUyBqQmZwKjXUm3QElE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYWM92kEV9sZQYZE+IoiYd+LLnZ5ojqPaAWW+P2pn3wTspngPTLaHzRH9ea1qpaia
	 0rGPj5L7/gG9nbCCL39NLONYXATaBjm3ceBaPj/v4JAdRcr33u8U5NhEUlk4/k9Eap
	 r1bONRh3z+0nP/r5rsGpiz7ZLbP9VOOt/kEKh11nuM3VT5W1obHfLjta2WiwyeZyPy
	 rTdNE6v5aKjqFqfZBb00KlcyOsA+fl0hfk6IAOub6Az5H1s2AlwFkUO015dVTEfSUr
	 vP0RU0+FENtIb3iHby1xuUnxeRj/HZaRgf8dR5VubZXfyCqk3GZ1OCikzGApHSYF1w
	 slM1+3Bv4AWfA==
Date: Tue, 6 Aug 2024 11:29:50 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: loongarch: Add la464 la664 CPU bindings
Message-ID: <172296538950.1842015.16091090445823251038.robh@kernel.org>
References: <20240802-la464-bindings-v1-1-4ccd299697f0@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-la464-bindings-v1-1-4ccd299697f0@flygoat.com>


On Fri, 02 Aug 2024 13:48:23 +0800, Jiaxun Yang wrote:
> Document LA464, LA664 CPU compatibles for emulation machine.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  Documentation/devicetree/bindings/loongarch/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


