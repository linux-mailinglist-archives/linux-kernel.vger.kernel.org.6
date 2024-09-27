Return-Path: <linux-kernel+bounces-342262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2AB988CCB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC27B1C204F6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B781B6549;
	Fri, 27 Sep 2024 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC/lmtg/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438051384B3;
	Fri, 27 Sep 2024 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727478215; cv=none; b=QJK16OQcMZ/RlzpqG6bkmLkv8gk+zV2EMuVDbWm+wfCAmBTAMp8xAOxaKubYW+ycjAF0RlQGoXI+/yq5Q3VpPeoLvIZsi+F63AqsaE4lrWVYh1fwRE44lZKdUyVwaicrF/0eCQmpGhCtnnldD/1/MzZP0Zj85hdHD2etWKESTFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727478215; c=relaxed/simple;
	bh=cDsTwguOFWY1iKRV1PzfSAUB+ha3Hm/urm6km6cIwQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcxH+iB0iGwlPrLL8hk7ExdLCMsCu2GQzvmbw0w/yPdBtUeCexMt4H/dFo9k+QVZZm3VNuPnq01HRgP2ySUEuNV8PLKOdca319ej/W1+n/wI1txezNM6152/t0TwARzNURGSqyFK0THuJxLSI8y38x6/WCgvj+FKibQ6H9FvXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC/lmtg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91996C4CEC4;
	Fri, 27 Sep 2024 23:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727478214;
	bh=cDsTwguOFWY1iKRV1PzfSAUB+ha3Hm/urm6km6cIwQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sC/lmtg/Dj6yYjZS40EzTKyfeqQSjFJ6ZCfNYohkRL+c3NEjFVeBZWLrkh3faHGm+
	 HgEQ3URuIO/pqDabxFvPBQ3V9unj4mvdf0YGB5umR55O5wbew9UZ/W1KKMADAhQGo+
	 xElAiqWim84+LeSJfZperGeDrPDoy17r+/28YvN4CeAhspGXANinQYI8f7/qK+iDhl
	 NknCvVbJIoslonMbTbGsRj9tCs210hU1/cL5+2ZnpeMe8U10mSBCCDXVUHFd/mUMgF
	 0gEbBSM25pybq9EwBbxgJNoiEKZ4WptN1sLWReqUtrBq1dLLYdzu2xgCc7O5hd1B+j
	 Q8kWLPiI89fkA==
Date: Fri, 27 Sep 2024 18:03:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-sound@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: fsl-esai: Add power-domains for
 fsl,imx8qm-esai
Message-ID: <172747821203.186059.10337981239925605095.robh@kernel.org>
References: <20240927205618.4093591-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927205618.4093591-1-Frank.Li@nxp.com>


On Fri, 27 Sep 2024 16:56:18 -0400, Frank Li wrote:
> i.MX8QM's esai require power-domains property. Keep the same restriction
> for other compatible string.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,esai.yaml        | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


