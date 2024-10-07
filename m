Return-Path: <linux-kernel+bounces-353505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D435992EBC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D141F22DF7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969411D61A2;
	Mon,  7 Oct 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9H/0q6D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E871D359A;
	Mon,  7 Oct 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310610; cv=none; b=ut6kQqtzmyIwBGSAPvYpq7/PsaURb81DFIl1HhmjnvlOn8llKjn8IRIqNjqqBFEJoy6EgKBMFFvhOEcY67qRb/vjGfd83JdolheN3DyUXJX/2bBq1jLU+Gh2tMtMRzOWA/V/vAkpiWLTa9nqkqkCSLFtiPRbpEbnqWi5rDFFES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310610; c=relaxed/simple;
	bh=90k/Q9Evo9k4FMfYcIURyr4AYubRR4XOFCioFwJxfN4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=dhmKqj03ipGs3tXbgBIHgMQGixR5CZE3z04xbLhRN+bnguxYEAgW/SVWaASEesMnTCH1vVaAXhp8+qzgY13MOMTayW0iayQClzH3Yodms3bHWdw2zUGLa2rysY6q1OR19geZv5EAWv6jwqEKdcHfM/Y1gcmSI4T7kdKaPMHRQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9H/0q6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54838C4CEC6;
	Mon,  7 Oct 2024 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728310609;
	bh=90k/Q9Evo9k4FMfYcIURyr4AYubRR4XOFCioFwJxfN4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=j9H/0q6DBVb5JsTnG+U4ySQqUCsXGWSB99um4CQxA6FsdMMzDdqn9bmPxa9H8g/8j
	 ObURpSMCvznlOdw70aRxYBO4lfHlK83TunQ7cLZf2lVB/tPAlXP+oQbZPKkRarECWp
	 9+IC6HYkwe4SZlG5ctHBMRE7U4vN5Xwczywng8Aea8pmXlf1Qj1AcdAbTYPgtlBT2A
	 aDtyNed8SBmMw7pm0vdmxYc0utZeAuRcC+YMp1UQJK80EHWzHJI9/3LVgDlm/ntIt0
	 ccues13Uu5Pa+NdCIbgSCJYf6fspkpyeLnZbXniVRY0KzQVkgrqNo8/9LEwN5wLuKj
	 W3y+2HONDq+ZQ==
Date: Mon, 07 Oct 2024 09:16:48 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: linux-kernel@vger.kernel.org, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Mathias Nyman <mathias.nyman@intel.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20241007093205.27130-2-francesco@dolcini.it>
References: <20241007093205.27130-1-francesco@dolcini.it>
 <20241007093205.27130-2-francesco@dolcini.it>
Message-Id: <172831060758.15259.15265542019562102842.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: add TUSB73x0 PCIe


On Mon, 07 Oct 2024 11:32:04 +0200, Francesco Dolcini wrote:
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> Add device tree bindings for TI's TUSB73x0 PCIe-to-USB 3.0 xHCI
> host controller. The controller supports software configuration
> through PCIe registers, such as controlling the PWRONx polarity
> via the USB control register (E0h).
> 
> Similar generic PCIe-based bindings can be found as qcom,ath11k-pci.yaml
> as an example.
> 
> Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2: rename property to ti,tusb7320-pwron-active-high and change type to flag
> ---
>  .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.example.dtb: pcie@0: usb@0:compatible: ['pci104C,8241'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241007093205.27130-2-francesco@dolcini.it

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


