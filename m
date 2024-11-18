Return-Path: <linux-kernel+bounces-413170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7D9D148D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADED282A67
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A41B1B6D0D;
	Mon, 18 Nov 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fU5Svm76"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BF1ABEA6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944176; cv=none; b=uUfFg/CVHpeB18ObCdAbFvJUjAo5e9+KW20jHC/0hzipfNTocUYuZ5Q6uCyBwb7Ztabg1QQvGOH7m5+Q71N0JmFmP7WBgJQmCIjp4zEsv//IA62tzvaPY5npaBP6vdBdd5M6lDJjsIrFha67InSKfWSWRafzR9P9ntNsLNixfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944176; c=relaxed/simple;
	bh=w2mRxyU6Wer/awZVdAQivc4uUlAOwE/wI67hCUOwwFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9Z/Pt+nMrn8A275fbynt6td7qQkYw4OL528xIo/jUn68gPhKWxj4TW18Bfaoly5Hqurn1KBcKyewV7jzxkgDL1lqIN/y1fj+fe1Xb3kjyAOA+DV/vbNkI5+wiLrpIOtsfAGLmrYm4+nKRyFkPv34WyHk7VjTw67y8d088voSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fU5Svm76; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e5f84c7-40fc-42e9-8521-f0f1e82e4d9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731944171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yM1hknJVFS7HCJh8Bw8WhrGpM3PfCvn6SKwbNFv5FAY=;
	b=fU5Svm76Z/VZZbJo2p5VhsyP12LlV0UA1Uytbdbxy5qBssiZCK13lQN3MOK/zoFdS+uU9G
	I3syYlgTcuRE22SKlpaP5MlmAvh7dYl2WxZtJ21mGibK/OZDMcOIbb20oLwWufXOX6lNQA
	ue+93MK0iQfvxGMWu5tkJxE2eNsOtrE=
Date: Mon, 18 Nov 2024 10:36:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: xlnx,axi-ethernet: Add
 bindings for AXI 2.5G MAC
To: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, radhey.shyam.pandey@amd.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-2-suraj.gupta2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20241118081822.19383-2-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/18/24 03:18, Suraj Gupta wrote:
> AXI 1G/2.5G Ethernet subsystem supports 1G and 2.5G speeds. "max-speed"
> property is used to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
> max-speed is made a required property, and it breaks DT ABI but driver
> implementation ensures backward compatibility and assumes 1G when this
> property is absent.
> Modify existing bindings description for 2.5G MAC.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  .../bindings/net/xlnx,axi-ethernet.yaml       | 44 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> index fb02e579463c..69e84e2e2b63 100644
> --- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> +++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> @@ -9,10 +9,12 @@ title: AXI 1G/2.5G Ethernet Subsystem
>  description: |
>    Also called  AXI 1G/2.5G Ethernet Subsystem, the xilinx axi ethernet IP core
>    provides connectivity to an external ethernet PHY supporting different
> -  interfaces: MII, GMII, RGMII, SGMII, 1000BaseX. It also includes two
> +  interfaces: MII, GMII, RGMII, SGMII, 1000BaseX and 2500BaseX. It also includes two
>    segments of memory for buffering TX and RX, as well as the capability of
>    offloading TX/RX checksum calculation off the processor.
>  
> +  AXI 2.5G MAC is incremental speed upgrade of AXI 1G and supports 2.5G speed.
> +
>    Management configuration is done through the AXI interface, while payload is
>    sent and received through means of an AXI DMA controller. This driver
>    includes the DMA driver code, so this driver is incompatible with AXI DMA
> @@ -62,6 +64,7 @@ properties:
>        - rgmii
>        - sgmii
>        - 1000base-x
> +      - 2500base-x
>  
>    xlnx,phy-type:
>      description:
> @@ -118,9 +121,9 @@ properties:
>      type: object
>  
>    pcs-handle:
> -    description: Phandle to the internal PCS/PMA PHY in SGMII or 1000Base-X
> -      modes, where "pcs-handle" should be used to point to the PCS/PMA PHY,
> -      and "phy-handle" should point to an external PHY if exists.
> +    description: Phandle to the internal PCS/PMA PHY in SGMII or 1000base-x/
> +      2500base-x modes, where "pcs-handle" should be used to point to the
> +      PCS/PMA PHY, and "phy-handle" should point to an external PHY if exists.
>      maxItems: 1
>  
>    dmas:
> @@ -137,12 +140,17 @@ properties:
>      minItems: 2
>      maxItems: 32
>  
> +  max-speed:
> +    description:
> +      Indicates max MAC rate. 1G and 2.5G MACs of AXI 1G/2.5G IP are distinguished using it.
> +

Can't you read this from the TEMAC ability register?

--Sean

>  required:
>    - compatible
>    - interrupts
>    - reg
>    - xlnx,rxmem
>    - phy-handle
> +  - max-speed
>  
>  allOf:
>    - $ref: /schemas/net/ethernet-controller.yaml#
> @@ -164,6 +172,7 @@ examples:
>          xlnx,rxmem = <0x800>;
>          xlnx,txcsum = <0x2>;
>          phy-handle = <&phy0>;
> +        max-speed = <1000>;
>  
>          mdio {
>              #address-cells = <1>;
> @@ -188,6 +197,7 @@ examples:
>          xlnx,txcsum = <0x2>;
>          phy-handle = <&phy1>;
>          axistream-connected = <&dma>;
> +        max-speed = <1000>;
>  
>          mdio {
>              #address-cells = <1>;
> @@ -198,3 +208,29 @@ examples:
>              };
>          };
>      };
> +
> +# AXI 2.5G MAC
> +  - |
> +    axi_ethernet_eth2: ethernet@a4000000 {
> +        compatible = "xlnx,axi-ethernet-1.00.a";
> +        interrupts = <0>;
> +        clock-names = "s_axi_lite_clk", "axis_clk", "ref_clk", "mgt_clk";
> +        clocks = <&axi_clk>, <&axi_clk>, <&pl_enet_ref_clk>, <&mgt_clk>;
> +        phy-mode = "2500base-x";
> +        reg = <0x40000000 0x40000>;
> +        xlnx,rxcsum = <0x2>;
> +        xlnx,rxmem = <0x800>;
> +        xlnx,txcsum = <0x2>;
> +        phy-handle = <&phy1>;
> +        axistream-connected = <&dma>;
> +        max-speed = <2500>;
> +
> +        mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            phy2: ethernet-phy@1 {
> +                device_type = "ethernet-phy";
> +                reg = <1>;
> +            };
> +        };
> +    };


