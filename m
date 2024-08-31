Return-Path: <linux-kernel+bounces-309732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B9A966FD8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC99B21D66
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284216DC01;
	Sat, 31 Aug 2024 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXcy5Q48"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E981531EC;
	Sat, 31 Aug 2024 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725086711; cv=none; b=A1iE5f7geuG9QjHJSPiROWJIqlZGU/rKiAz3DnXohIc+8ZhLxV4BN1h8pQej/OQ2TWRd+ZNpigFJoRMcac4GCzURXnVUwyatiT4y5RJWXyalsuw3do1wWWOLGqbMMvFij4I8rDAGwchZoIhI3svyOh74+kgFNj4qG0VRTnY2swU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725086711; c=relaxed/simple;
	bh=YQxFvPtFVn65zjVFNDWqYLwX0f/ZUYN3hDh3r4s78u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+V9ec20tKyj4NlAZXYCHoLcMfjko3HfytbzLeH34EpcXLO2rIWxYLAMAVnK+mnUf7947GifnyAgQCrMr/c+nO2DQNIVdg8+2CZM4sbcF/d1bqPLvh3VMdjo5O6DbzOHs9QBVwASEm+A4TF7WayImqABRuwASZW1yPBKvwtTOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXcy5Q48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FF7C4CEC0;
	Sat, 31 Aug 2024 06:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725086710;
	bh=YQxFvPtFVn65zjVFNDWqYLwX0f/ZUYN3hDh3r4s78u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXcy5Q480m0vHk/ItLSIjlWH92yJWd+qNYN2jmSBNXPak3JpFoEMex3xuknY9SAxy
	 NEO+B+zA/gMwWBBC3IxDjv0z/8ODij7B4mFJGignbHzxp2k6JwTwqy8uOUXTtgDfW2
	 EZer4JBnpNEuZJlDY+RznswqCFv/m4z3vOxCYySvV4Ul2qZaA72lBLjXIUH2CzwxoK
	 d4x+ni4Yzr7JXNY4f50EHjB7yK9fx5GYUngSJ3RrTdgKRmh5Y82K2rdBnszncPbmXw
	 Yiu09JTCw7FY7gDQ+w1N5gksuhbpxZ/TZk9wo0v9Kk8SlVTOHpCd/3j1ifVxOMWuRy
	 Q0x1E2UN/II5A==
Date: Sat, 31 Aug 2024 08:45:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	cyril.jean@microchip.com, valentina.fernandezalanis@microchip.com, 
	nitin.deshpande@microchip.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] dt-bindings: add IP versioning document for Microchip
 FPGAs
Message-ID: <4lsua4cxpxlla4i5rn7zmw3tvkbxz664a7as6jqy6qceljlj4x@ssev4fvuqz36>
References: <20240830-culinary-cautious-2c2c19902dcb@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830-culinary-cautious-2c2c19902dcb@spud>

On Fri, Aug 30, 2024 at 05:00:40PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> This is a pretty rough document I conjured up in 5 minutes, to document
> my expectations for compatible strings for both our FPGA IP blocks and
> reference designs that we ship, a la the one that exists for SiFive IPs.
> There's been some internal conversations lately about this naming etc,
> so good to have something written down.
> 

You can try to make it a schema. Take a peak at:
Documentation/devicetree/bindings/arm/qcom-soc.yaml


Best regards,
Krzysztof


