Return-Path: <linux-kernel+bounces-283364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332FF94F187
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35B3282B01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F4183CCD;
	Mon, 12 Aug 2024 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGSJCj+x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946C130AC8;
	Mon, 12 Aug 2024 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476050; cv=none; b=Xoxo6YzOurdmRtsW3Z/uTEjd/HuF01tsF6AztjB4DXECFaWcXGGjn6uwyvS4j5dG8u9JYHDpNtZm7qStBcjm00PMtlBZwEW0qTqBm2dq3IDAS3de2Wr0bSNwWq2StTnlymCKMMB1Q1fAEjEGfwTRaDv5IgpXoGueEbJFbStJOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476050; c=relaxed/simple;
	bh=VnLGDmiaS2Z5tkjkWIn8CfimR/QHZ7JqU5+27LaswZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ns4mTA1ZLCy7f6TmjIxNV/pgk/DVHV/RAwtAmP5CSEYpcGOHI8Bn2wvqW87YNPm7hV303Th58ibcLB6+aTVwYVNwBYcnEfeSco+s09NGbK7qi7ixxlgeMA/eQ/Rz+CIly2acnLB5tR5IPKH1ZC4vFrqss+1/QV9gaeP+7ImsTHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGSJCj+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E8AC32782;
	Mon, 12 Aug 2024 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476049;
	bh=VnLGDmiaS2Z5tkjkWIn8CfimR/QHZ7JqU5+27LaswZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGSJCj+xyE8GhlEPNNPT6Z8/M2R+2J0KBUK78fhmm0QDMf+McYucSTLqbxkeOs43i
	 LzDaM79Eh6+GBcdURLwNB05moUu9GvoHYg7ahOFshYExHJIou/761s7K8Ues8sYFVS
	 S9GvRps8jicURswrHPm3YB7bLZTnVhvMl7vl0LmYnx7BOSsXe4caUAmakorg+hEtwc
	 QLKB12/zdCNxmKC27fMQcBKqLTdFCSg3OToHxBSuTLlHgHlYwY6swLRKkDRfLgc+dQ
	 ohqSCphktXWOuO+CTUbEjU0kE8BffKSDXYwUqbEDgfrdVdMsW9CluNaMjGew/si9by
	 YmJQ8/A19HrIA==
Date: Mon, 12 Aug 2024 09:20:48 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: kishon@kernel.org, fabrice.gasnier@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	vkoul@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, mcoquelin.stm32@gmail.com,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
Message-ID: <20240812152048.GA593866-robh@kernel.org>
References: <20240812120529.3564390-1-christian.bruel@foss.st.com>
 <20240812120529.3564390-3-christian.bruel@foss.st.com>
 <172346965242.493337.13574697496053856.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172346965242.493337.13574697496053856.robh@kernel.org>

On Mon, Aug 12, 2024 at 07:34:12AM -0600, Rob Herring (Arm) wrote:
> 
> On Mon, 12 Aug 2024 14:05:26 +0200, Christian Bruel wrote:
> > Document the bindings for STM32 COMBOPHY interface, used to support
> > the PCIe and USB3 stm32mp25 drivers.
> > Following entries can be used to tune caracterisation parameters
> >  - st,output-micro-ohms and st,output-vswing-microvolt bindings entries
> > to tune the impedance and voltage swing using discrete simulation results
> >  - st, phy_rx0_eq register to set the internal rx equalizer filter value.
> > 
> > Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> > ---
> >  .../bindings/phy/st,stm32-combophy.yaml       | 178 ++++++++++++++++++
> >  1 file changed, 178 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml: access-controllers: missing type definition

Ignore this. It's a problem with the build.

Rob

