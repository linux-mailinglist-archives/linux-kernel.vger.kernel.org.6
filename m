Return-Path: <linux-kernel+bounces-510108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F5A31849
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71563A6F48
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DBF267B08;
	Tue, 11 Feb 2025 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IivS/s9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1B267715;
	Tue, 11 Feb 2025 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310837; cv=none; b=rt1NA6aE1ASt8E4DqMbxNpCVe9M3GhdH75o2PJ8VPt2+Atyypw3w6WVbT1Hu3Iu0n8grTob1H5DBoWjgwt05hQksuKWhfjYQtuCGmzneEhqOZ/daQZEOdzOOm9KNaZC1+YoamYHauRFP1dcBgzapEDZkTd9nmapINKMZeGWeIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310837; c=relaxed/simple;
	bh=ZOTDV0C3q2CDB3rQM196vlVvGcBuD+GPHBG7B+1efHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIjs6oEAtcV5Wi1q2rxayjtZYgvAJwP1MolB3CIQfL+9sIsNGVAlmrMp+pAPB3Tt4rHJrpBzUWsEJvhDBi/feHdx148ceF0pdTxwkKi7FWdM1kum5pjGlVm9OIj2xJUJJ9807iRsVIRLDiYgha9yqjJuxS3sJ3CZq6PeUeP+vbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IivS/s9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B36C4CEDD;
	Tue, 11 Feb 2025 21:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739310835;
	bh=ZOTDV0C3q2CDB3rQM196vlVvGcBuD+GPHBG7B+1efHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IivS/s9ULuONCMV6OfzkHOa/ur5svrKqO2MIkv0VAqg31CKNhm3tun4ISAd8k2Umc
	 XVy7223Zs/zbBsqCd4Nm0sJ2mKy/h7hU/asbJCnHfAOSl3WHbOAh+5HesEm4An639Z
	 aW/VF3DRmBJZNOF5IAewC9R+TZpV0XcddukUC66t49R0wqVkTzzLnHhOjHDtiJB+1l
	 eQskcocha5U+xl6QGdXW3ERb2XCuHVQZiX+nd1O5KVqDnAEoMTj48dO+fNi+dGw/fB
	 qZ6jR8Y5CmmOeG+PodM2Ijda05H+ShMp2G0SKGWFkvPPCkUo0GZpy4LEIu62PQkK6r
	 4DSgBrgdEQ49A==
Date: Tue, 11 Feb 2025 15:53:54 -0600
From: Rob Herring <robh@kernel.org>
To: Ronak Jain <ronak.jain@amd.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
	nava.kishore.manne@amd.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional
 pinctrl schema
Message-ID: <20250211215354.GA1244436-robh@kernel.org>
References: <20250206142244.2553237-1-ronak.jain@amd.com>
 <20250206142244.2553237-3-ronak.jain@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206142244.2553237-3-ronak.jain@amd.com>

On Thu, Feb 06, 2025 at 06:22:43AM -0800, Ronak Jain wrote:
> Updates the Device Tree bindings for Xilinx firmware by introducing
> conditional schema references for the pinctrl node.
> 
> Previously, the pinctrl node directly referenced
> xlnx,zynqmp-pinctrl.yaml. However, this patch modifies the schema to
> conditionally apply the correct pinctrl schema based on the compatible
> property. Specifically:
> - If compatible contains "xlnx,zynqmp-pinctrl", reference
>   xlnx,zynqmp-pinctrl.yaml.
> - If compatible contains "xlnx,versal-pinctrl", reference
>   xlnx,versal-pinctrl.yaml.
> 
> Additionally, an example entry for "xlnx,versal-pinctrl" has been
> added under the examples section.
> 
> Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> index 2b72fb9d3c22..d50438b0fca8 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> @@ -76,7 +76,6 @@ properties:
>      type: object
>  
>    pinctrl:
> -    $ref: /schemas/pinctrl/xlnx,zynqmp-pinctrl.yaml#
>      description: The pinctrl node provides access to pinconfig and pincontrol
>        functionality available in firmware.
>      type: object
> @@ -106,6 +105,21 @@ properties:
>      type: object
>      deprecated: true
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: xlnx,zynqmp-firmware
> +    then:
> +      properties:
> +        pinctrl:
> +          $ref: /schemas/pinctrl/xlnx,zynqmp-pinctrl.yaml#
> +    else:
> +      properties:
> +        pinctrl:
> +          $ref: /schemas/pinctrl/xlnx,versal-pinctrl.yaml#

The somewhat preferred way to do this would be to do this in the top 
level:

pinctrl:
  type: object
  additionalProperties: true
  properties:
    compatible:
      contains:
        enum:
          - xlnx,zynqmp-pinctrl
          - xlnx,versal-pinctrl
  required:
    - compatible

Otherwise, the pinctrl schema ends up being applied twice.
 
> +
>  required:
>    - compatible
>  
> @@ -164,6 +178,10 @@ examples:
>          compatible = "xlnx,versal-fpga";
>        };
>  
> +      pinctrl {
> +        compatible = "xlnx,versal-pinctrl";
> +      };
> +
>        xlnx_aes: zynqmp-aes {
>          compatible = "xlnx,zynqmp-aes";
>        };
> -- 
> 2.34.1
> 

