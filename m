Return-Path: <linux-kernel+bounces-234438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C61CC91C6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498AA1F240A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1DC76026;
	Fri, 28 Jun 2024 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW7PCzVX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964354CB4B;
	Fri, 28 Jun 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603246; cv=none; b=Pq4ey8s4qALlJurFZCEaS4ppnkVeirppOnLPtnn21Qjrxlo5WlEwqzpR0YFoEBZ8x53IDjTi9H2x6OsttUlmJrfKUgugSmzTGjl02J3/lEAbAJ5rNq1JUHLm5mrTQa5OsjD6NMWFEZbPcMeeozd+Tza6Jbni3hBShAh7BXPLdK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603246; c=relaxed/simple;
	bh=yjCUTIYEfShWpFf89z1mVEG427+uOb9/A8IYTG9e/NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxI/vZde9tWqxfTKgi6Lg/VRiMp/X27RXLBV7vDSUrLkO4a1S1UBGENSoi6CYdgDkmUmlRghxVSgo7HMwSVB7TyoBV/BQUa6s6L4ESjKfGZ92oAwAVC3B1ulYBMIBBTFpKEvbUkF2TZFRNYk3+4OM0pV6WB06PdDb3Ojpqst7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW7PCzVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0591C116B1;
	Fri, 28 Jun 2024 19:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719603246;
	bh=yjCUTIYEfShWpFf89z1mVEG427+uOb9/A8IYTG9e/NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SW7PCzVX3hluUKlCIYLBXkd409r8ZtagalI+cC5oRATkdJDzhkspjuEdvljwoAKC3
	 vQJ6YP+YPTnI5dsUIFpD1ZVwU48sbb7jgwrNVxoffS6u43IRf2AbrH/u2cWXBSnFcH
	 rsh1ICVvPDoNrqHLF5AA1sB0NAkCq78Xvh5+lXIBJ/LHOlwyS8HS2NbM+5NVU3sB2H
	 sk17EFxOOkmgv1h6WKuFOcAdyiGcaMsE0liX1Eu9dh+jHH4ZTMo93ZnOuGthcH70E2
	 cmC8ybSf6k7OOUusaGff9Nv2//61BM93dz8t39YZkNywe9Uo843EKpWeYM5nnj9j3k
	 hTjcmmuNRi43A==
Date: Fri, 28 Jun 2024 13:34:04 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: soc: fsl: Convert q(b)man-* to yaml
 format
Message-ID: <171960324209.86780.5210954798222723537.robh@kernel.org>
References: <20240626193753.2088926-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626193753.2088926-1-Frank.Li@nxp.com>


On Wed, 26 Jun 2024 15:37:53 -0400, Frank Li wrote:
> Convert qman, bman, qman-portals, bman-portals to yaml format.
> 
> Additional Change for fsl,q(b)man-portal:
> - Only keep one example.
> - Add fsl,qman-channel-id property.
> - Use interrupt type macro.
> - Remove top level qman-portals@ff4200000 at example.
> 
> Additional change for fsl,q(b)man:
> - Fixed example error.
> - Remove redundent part, only keep fsl,qman node.
> - Change memory-regions to memory-region.
> - fsl,q(b)man-portals is not required property
> 
> Additional change for fsl,qman-fqd.yaml:
> - Fixed example error.
> - Only keep one example.
> - Ref to reserve-memory.yaml
> - Merge fsl,bman reserver memory part
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - fix typo chang
> - fix typo porta
> - Add | for reg description
> - wrap to 80 for reg descritption
> - memory-region set maxItems: 2
> - fix regex parttern
> - drop  See clock-bindings.txt
> - "see reserved-memory.yaml" change to
> "see reserved-memory/reserved-memory.yaml in dtschema project"
> 
> - A strange thing in fsl,qman-fqd.yaml, if example compatible string
> change to fsl,qman-fqd, dt_binding_check report below error.
> 	qman-fqd: False schema does not allow {'compatible': ['fsl,qman-fqd'], 'size': [[4194304]], 'alignment': [[4194304]], 'no-map': True, '$nodename': ['qman-fqd']}
> 
> but I replace "fsl,qman-fqd" with "abc", it pass check.
> ---
>  .../bindings/soc/fsl/bman-portals.txt         |  56 ------
>  .../devicetree/bindings/soc/fsl/bman.txt      | 137 -------------
>  .../bindings/soc/fsl/fsl,bman-portal.yaml     |  52 +++++
>  .../devicetree/bindings/soc/fsl/fsl,bman.yaml |  83 ++++++++
>  .../bindings/soc/fsl/fsl,qman-fqd.yaml        |  69 +++++++
>  .../bindings/soc/fsl/fsl,qman-portal.yaml     | 110 +++++++++++
>  .../devicetree/bindings/soc/fsl/fsl,qman.yaml |  93 +++++++++
>  .../bindings/soc/fsl/qman-portals.txt         | 134 -------------
>  .../devicetree/bindings/soc/fsl/qman.txt      | 187 ------------------
>  9 files changed, 407 insertions(+), 514 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/bman-portals.txt
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/bman.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,bman-portal.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,bman.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman-portal.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/qman.txt
> 

Applied, thanks!


