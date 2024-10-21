Return-Path: <linux-kernel+bounces-375041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665F59A9021
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E28F281645
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF871CEEBB;
	Mon, 21 Oct 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyhZIGvk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E07A1CBE8E;
	Mon, 21 Oct 2024 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540213; cv=none; b=mu+2vrfVX3GpxQUNtVQelxultllgsGlp8BM87IEE8ryTGcdaEmNYxz9rJ2EVaipk8x0kQlaBJT/onJ0YGq8JSlaHxcDtZsR/GE/UZrppJU9Gf+y0SVLNZksPyCLjq41EoEqzdKR2F4rnBt3nl3rpzw50LlOEs9Nv0zRytzk2M0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540213; c=relaxed/simple;
	bh=eZYf3GJHPEiM9OohyeCcgFDCaHIVP50U9kyroIh1Xm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJCik6I+qY1SOd41hCMgU2TTFTRSTBllQ5FUZN54QeJ8gXBAV+z1yGQrmVDzEtHIDM81FI+PIzXmsFETHEjAv/ok5P5hXkdmyx3Mq6DIn9Uch+Hx32tkFsvEWNn75Wk8pisHJnJVAwtdvTleVHglF81e2mMf8dSks0M9MqnmuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyhZIGvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64046C4CEE5;
	Mon, 21 Oct 2024 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729540212;
	bh=eZYf3GJHPEiM9OohyeCcgFDCaHIVP50U9kyroIh1Xm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyhZIGvkS2Onm//7dOxuVzku5f4l75aicLhlLCLxV+xc4DCV6MbYTlEHMhpiFK2/D
	 Ig2V5GO1I20kaQOYfAVPjexFqjmrR154+RmH92/WvOro4oUR88cZpdpdWTXcU5e54o
	 xVBOGpqmtSpcWovV45eGhiAk0EyFAuXnJ1oDm7TGWfPJQykSut9PIXa3E2T8Y5Fnyt
	 w63ClYON3N/XKApIdPju660n8Ddig3FGo6JZ598U2i3vXsH+TR89/uBhL0aaVWn4GD
	 M/4/oivOKvJ6DBk3Y8LX60FdFoQm5dcIR5H4H+PB/ekWDBaEgqfPsTDBTOxMv9iaNX
	 5+N44evzinVTQ==
Date: Mon, 21 Oct 2024 14:50:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
	linux-arm-kernel@lists.infradead.org,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Open Source Submission <patches@amperecomputing.com>,
	Phong Vo <phong@os.amperecomputing.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Khanh Pham <khpham@amperecomputing.com>,
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Mt. Jefferson board
Message-ID: <172954021092.1028025.10007351603543504033.robh@kernel.org>
References: <20241021083702.9734-1-chanh@os.amperecomputing.com>
 <20241021083702.9734-2-chanh@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021083702.9734-2-chanh@os.amperecomputing.com>


On Mon, 21 Oct 2024 08:37:01 +0000, Chanh Nguyen wrote:
> Document Ampere's Mt. Jefferson BMC board compatible.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
> Changes in v2:
>   - Document Mt. Jefferson board compatible                   [Krzysztof]
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


