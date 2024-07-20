Return-Path: <linux-kernel+bounces-257981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 917059381B0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 16:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A5B281EAC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AE7133987;
	Sat, 20 Jul 2024 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r671OLH8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190E10A0C;
	Sat, 20 Jul 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721485836; cv=none; b=cxYRU4nDw575TgI4Q7tyWfw8NKuHoGmmgKIBuWz9JjVBsj6PHfPR8CMFrGdSHME+ZJZy+Algs9e+emwQ783Z2p9mU3PXVrAlNzgnht5NrQv8Vjm1ZSMYEKJazWH+GND/j2XIuJ2MjC/ERBzWTwQbhBtv/iXAM3EtdGmQVBkYJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721485836; c=relaxed/simple;
	bh=NfbtvAWiMt9MczyRLWxn9ec6rKJ5Bqdhv3OIUpIXJZg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=YIWCRqvqvyRQvokBGD9JidjwMFvKMGMc6k+WF19rFtxNoyUf4OK6iNszWUwDLMScLw0zHCdtVJCqTQ//6dasbaosSrJOlN9IKm6loRkR47YL6fYfrpYcf/YZtOYDJZ9r+zDM8RKqsz6IbgCRyWRUtL56d8eqOS8GNqUk96yITuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r671OLH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E85CC2BD10;
	Sat, 20 Jul 2024 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721485836;
	bh=NfbtvAWiMt9MczyRLWxn9ec6rKJ5Bqdhv3OIUpIXJZg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=r671OLH8v15hwoXYlK9INmUs2I7htKx70mYiUmsSn96p+gwx831mC2zl5d9lxero7
	 9wYQYZP2iv6s5pYKx9UVEfmy4GxO9STKfrVkTxZ58wqyIRLmMGLTC3Gy0g++gJJf2J
	 uTjkCxWCZL0m4WVbXR4h8vsgQttfL1/9O0ZFxirQLh5DOJofhU8R5JrJpbjwBOfBSd
	 pa6ATIfNnJ6fZI0U82smpt5uxy6CCGdWYzPwr3dKpmsuMpBmine412iUKTV/Xbt5mD
	 6hlEZGq14vsbexfghx/CtzbnCvSs7A19yt3NIvlrGkWElHFxJNnTiepZvFPqEJRPQN
	 7Uj+P44LgkBYw==
Date: Sat, 20 Jul 2024 08:30:32 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Harry Austen <hpausten@protonmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Michal Simek <michal.simek@amd.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
In-Reply-To: <20240720120048.36758-5-hpausten@protonmail.com>
References: <20240720120048.36758-1-hpausten@protonmail.com>
 <20240720120048.36758-5-hpausten@protonmail.com>
Message-Id: <172148583272.233332.12140036278167127685.robh@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: clock: xilinx: add description of
 user monitor interrupt


On Sat, 20 Jul 2024 12:01:48 +0000, Harry Austen wrote:
> This Xilinx clocking wizard IP core outputs this interrupt signal to
> indicate when one of the four optional user clock inputs is either
> stopped, overruns, underruns or glitches.
> 
> This functionality was only added from version 6.0 onwards, so restrict
> it to particular compatible strings.
> 
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---
>  .../bindings/clock/xlnx,clocking-wizard.yaml  | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.example.dtb: clock-controller@b0000000: 'interrupt-names', 'interrupts-extended' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/clock/xlnx,clocking-wizard.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240720120048.36758-5-hpausten@protonmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


