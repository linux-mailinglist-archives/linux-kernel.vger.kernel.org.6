Return-Path: <linux-kernel+bounces-290333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B25955256
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF2E284502
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3AD1C579D;
	Fri, 16 Aug 2024 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj04kprW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCF81AD7;
	Fri, 16 Aug 2024 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843674; cv=none; b=CAa4ubY/XRsKervXbp6EL0qBDpeMjT/lsPzKYoU2twi6x8fX/jmFODxL+5sQbwM6vfIKOOuCO85/suiB+RZYIbgUcafMlCsJNy+V9r/5AaW2soN/YAw1cd8TYBx1s/b76ddku6q//omdnMBqq3jdXN2tmjw7dVu+5yN2ffBOT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843674; c=relaxed/simple;
	bh=dIxN9KEXuTIHRmzuZuqIU1jbaEnvfmetlSXMxrcGzSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN7qEDXTaGu5+sMcmJhfV8a99yXeWtj6RW1RORenraJNEhwmS2rVufTTXuKnqVPvf271O1x1HyEFWpNQ0CtkfcROyBDatO/Dt5M+V+AOR7KudMvxZITxenJ9E8KkLkjwwmtzPKfAl+605k6LWCUkqqrqz7miP4Ri9JGjiNjIz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj04kprW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7504EC32782;
	Fri, 16 Aug 2024 21:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723843672;
	bh=dIxN9KEXuTIHRmzuZuqIU1jbaEnvfmetlSXMxrcGzSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gj04kprWR+dy5f3f8+UkrFLu6HEQ/yhxGKy4H74kpN4XY0z2/zR/3/0FyCouv9uFp
	 5FrzJAmGy4nKeAU+UUKIVx+nmhu3wxdbYt++wsQMK6HXS5aUkOkQJtqtR2t/bEkebj
	 9PIKZSGlWz3C+BNOCPx5NK+kjJjTIpvqwZJfVUPpy8K0BTUJVBPjopWqrxDcYepZ9s
	 lxsm+Vjf6flcHCqprrESI2iJlrOEU0oeJf6IKd0BkvECDh7glfNjdalJ9bvZlKzBUF
	 HbOpCfQAK44Xq9Xy1tn1oTYv30eVJkifF2Gj18aURKNcchyTfCLNA6sfm35Ody6BMJ
	 SX63MpjKbGMag==
Date: Fri, 16 Aug 2024 15:27:51 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: board: convert fsl-board.txt to yaml
Message-ID: <172384367013.2245734.13242997250124317932.robh@kernel.org>
References: <20240813163638.3889778-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813163638.3889778-1-Frank.Li@nxp.com>


On Tue, 13 Aug 2024 12:36:29 -0400, Frank Li wrote:
> Convert binding doc fsl-board.txt to yaml format. split to 3 part
> fsl,bcsr.yaml, fsl,fpga-qixis.yaml, fsl,fpga-qixis-i2c.yaml
> 
> Additional change for fsl,fpga-qixis.yaml
> - Add childnode mdio-mux-emi*
> - Add compatible string fsl,ls1043aqds-fpga, fsl,ls1043ardb-fpga,
> fsl,ls1046aqds-fpga, fsl,ls1046ardb-fpga, fsl,ls208xaqds-fpga,
> fsl,ls1043ardb-cpld, fsl,ls1046ardb-cpld, fsl,ls1088aqds-fpga,
> fsl,ls1088ardb-fpga, fsl,ls2080aqds-fpga, fsl,ls2080ardb-fpga.
> - Change address to 32bit in example.
> 
> Additional change for fsl,fpga-qixis-i2c.yaml
> - Add mux-controller
> - Add compatible string fsl,ls1028aqds-fpga, fsl,lx2160aqds-fpga
> 
> Fix below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/i2c@2000000/fpga@66: failed to match any schema with compatible: ['fsl,ls1028aqds-fpga', 'fsl,fpga-qixis-i2c', 'simple-mfd']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - drop description in fsl,bcsr.yaml
> - bsc9132qds is too old, their dts have not simple-mfd.
> - split qixis-i2c compatible to two group, one with simple-mfd and the
> other one without simple-mfd.
> - Add new full example for ls1028
> - Remove [0-9], keep @ for mdio-mux-emi. Dts need be update to avoid
> warning
> - fix typo dt-binding in subject
> ---
>  .../devicetree/bindings/board/fsl,bcsr.yaml   | 32 ++++++++
>  .../bindings/board/fsl,fpga-qixis-i2c.yaml    | 70 ++++++++++++++++
>  .../bindings/board/fsl,fpga-qixis.yaml        | 81 +++++++++++++++++++
>  .../devicetree/bindings/board/fsl-board.txt   | 81 -------------------
>  .../boot/dts/freescale/fsl-ls1043a-qds.dts    |  2 +-
>  5 files changed, 184 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/board/fsl,bcsr.yaml
>  create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
>  create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
>  delete mode 100644 Documentation/devicetree/bindings/board/fsl-board.txt
> 

Applied, thanks!


