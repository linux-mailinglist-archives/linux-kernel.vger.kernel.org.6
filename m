Return-Path: <linux-kernel+bounces-285376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FAE950CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBD01C228A4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5057E1A3BC1;
	Tue, 13 Aug 2024 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaQGJ4ZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36D1BF53;
	Tue, 13 Aug 2024 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575687; cv=none; b=jRP6I8TJKkc0ufm/wmIREZdGTJDSvQe9Z9XYsAsRLdv79+4KMvW9j1tFGO6qCaYHMRgs6wTY5680CRCNZJg7TFxC/+RVrFPmbwDCKxbrwA0zdpyFOYcyTWUeOzvUHTHbDJG4esjry4UpeiazezItV12r6WW5x3AX81/IklOWA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575687; c=relaxed/simple;
	bh=renmw59HKxMX5MC5Hbv+XrZT1TC9Hrv/wjdkVhu1QGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i02+Fge9k9wY+jBQPenNBXRIWDf1vGsHpcSEofoxKEbeh3X+/zwMkcOfapwieX6WxQbQt2zqanlIaPir706Ts6VzIqtfWxJHiVEA+Q2W+ZvAPxpwfGCreH8zQfzFyydX2//BK65o/vMfgSWK8pPeGwWYL4rlPOnf/MgXiPbHAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaQGJ4ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF127C32782;
	Tue, 13 Aug 2024 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723575686;
	bh=renmw59HKxMX5MC5Hbv+XrZT1TC9Hrv/wjdkVhu1QGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaQGJ4ZCSgS//R/BPnue0w1ew0ivihpN0P8gDojYPDDh5WnD/D3v4XyvuUkh7yTFx
	 dO4E4klxoPzahE8evwJIg6hc16C1X6h4CP3LzNAyO5zXO5wW0IBc8L15jO3R4IC6sh
	 OyBENSWg6koViMKG715xqbjeeph02tqzUfkj8VcdJFQjm4yl18yVw971sLJbKUS6YV
	 EuGDNVfoXqHAkng9u2DiAjA+MT5EwsWGPZHlI61YHHd/aBTFNqS/de84/7xNW0S5Sp
	 PZzvB/cIVj+ZF7+FdMVa6yRpMwFfaQ6S7DF3n85wj7/vqiyiSz/Ufmjg50YtZXNrxW
	 weknuk/ErC8Dg==
Date: Tue, 13 Aug 2024 13:01:24 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: devicetree@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Qiang Zhao <qiang.zhao@nxp.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 07/36] dt-bindings: soc: fsl: cpm_qe: Add QUICC Engine
 (QE) TSA controller
Message-ID: <172357568355.1494768.17469941704094420222.robh@kernel.org>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-8-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808071132.149251-8-herve.codina@bootlin.com>


On Thu, 08 Aug 2024 09:11:00 +0200, Herve Codina wrote:
> Add support for the time slot assigner (TSA) available in some
> PowerQUICC SoC that uses a QUICC Engine (QE) block such as MPC8321.
> 
> This QE TSA is similar to the CPM TSA except that it uses UCCs (Unified
> Communication Controllers) instead of SCCs (Serial Communication
> Controllers). Also, compared against the CPM TSA, this QE TSA can handle
> up to 4 TDMs instead of 2 and allows to configure the logic level of
> sync signals.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml   | 210 ++++++++++++++++++
>  include/dt-bindings/soc/qe-fsl,tsa.h          |  13 ++
>  2 files changed, 223 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml
>  create mode 100644 include/dt-bindings/soc/qe-fsl,tsa.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


