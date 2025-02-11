Return-Path: <linux-kernel+bounces-510118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C2A3185F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12543A6B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E142268C66;
	Tue, 11 Feb 2025 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhDQssDb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06691267735;
	Tue, 11 Feb 2025 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311477; cv=none; b=aVJDNBT+IOi/h/bPbPdBwgHgwUPLwXNXCk5OG9AKnOUodYM07LHcTmPFPvXOjzqWyuUYy+aF3YUbFkYPh11GrLxxtfpX9XzOMCvXTamCK8kSrhBaqb4IEk9KMT1l5oubMPkOQUHxQwka7DiPCt940Jhy0wxejzGcjCQ3eT0aUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311477; c=relaxed/simple;
	bh=uMKBhZHWHA8g2rPum0wPT8UZWPSfeTkN6vCMYZZBBBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1mBb+C1RkYdzYguyQVdQaymBXEP0GbcbB70X1rkXQZBH95pS3bfchhCHAZONGy64LaK28iVlWS6TAj4fDovl6eDJYmogHaQ5XiytGRWiqYxkfr56S7uptccx+wzYoSegLIwSKlDsAzL0vnIoYYezqwPi8kyHAMpmV3lbexOQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhDQssDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39895C4CEDD;
	Tue, 11 Feb 2025 22:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739311476;
	bh=uMKBhZHWHA8g2rPum0wPT8UZWPSfeTkN6vCMYZZBBBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhDQssDb3byCKjhbMltioNTDQ3sdU2sd0bLMQPUEgxb7er+DcCAdAlcr5Wf5FuTaC
	 vfACb/l2/oanput6gyBERu8V7jeGDWm3o8c4xJsn5EcA2zk1Ap5QG/9i05+b94YLrQ
	 Fh599IjPljwmp9ARx0TVwXtmQi3c54wAL5aZdHNFG98nXgidVcQdmucKF51NKdhBO3
	 azLdH8J7swmQG3ZGnJa4eAzj+9OsTdFIipA7O4PTumYAyN1QLp5wdXEAIUdpk3nkXi
	 kKWkSnSUCGrr7uO+44ST/KmVan7LzbKs1VmT/NW0uDpidPfsXqJ2XPVElz9E11vPPx
	 XbzBPDb+u/fcg==
Date: Tue, 11 Feb 2025 16:04:35 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ronak Jain <ronak.jain@amd.com>
Cc: michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	nava.kishore.manne@amd.com, krzk+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: firmware: xilinx: Add
 xlnx,zynqmp-firmware compatible
Message-ID: <173931147455.1264295.4744633956351732419.robh@kernel.org>
References: <20250206142244.2553237-1-ronak.jain@amd.com>
 <20250206142244.2553237-2-ronak.jain@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206142244.2553237-2-ronak.jain@amd.com>


On Thu, 06 Feb 2025 06:22:42 -0800, Ronak Jain wrote:
> The absence of a compatible property caused dt_binding_check to skip
> the zynqmp_firmware node.
> 
> To address this, add "xlnx,zynqmp-firmware" to the compatible property
> in the example section for the zynqmp_firmware node.
> 
> Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> ---
>  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml           | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


