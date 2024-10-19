Return-Path: <linux-kernel+bounces-372947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6119A4FB9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549C2B232B0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB518C937;
	Sat, 19 Oct 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+QWYHi7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160D324A08;
	Sat, 19 Oct 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729354930; cv=none; b=ZHT37osTgjEif6G7u5CsJIEmicSiOCkNsE+LmDuY7OLJporR40e/f3p4rvTaVrxPMEOTTEchSdfqczI+oCwf4VCWbOAt269XhR4COrsgi8aQJtoTNNZg0+jS2llfKbqYeCdJHV9hiskxSgvFh1rCIuYvaTTT7kU7K7V6bhAsM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729354930; c=relaxed/simple;
	bh=DcuAnW//1Mdx7y7zOFVfzAiHbwgjfTP/YPbAj8XfRnM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FFBPzbkWjFjb8YhFbEe+6/Z5QCJVwWHPF0ld0pnDMDClGhgVpRIUnkg0l+zTQFTpgF+LxIowogWr9rWlaGkMqMtk+XoX6hc9o7i3NaAjDMAL0LgQdnhLz33ppnfGhrKxKgzYNirZx5+znFhCGS4+LyObsQL3OqlVg8DjXJ5YLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+QWYHi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF06C4CEC5;
	Sat, 19 Oct 2024 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729354929;
	bh=DcuAnW//1Mdx7y7zOFVfzAiHbwgjfTP/YPbAj8XfRnM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=M+QWYHi7YxMyzE1KvSB88DpXJTWA19f6JdCnOWfPXbnEpLCnN31xgB2GBkdaJ1hRf
	 ooi//Q9TB1+JyxP91XP2soORrZC9XCAQn5aMroD+8G8FyxKwBSfkZeWJG0S8epQgjz
	 EGHECYSePaorTD1QwFm70/91GdC1LPabM58fz3648t7QChwNUGlO6n00A3F+0BucRC
	 yONoSLfvVwsMlRUEfZTSsB2sOU0aFhpGrGCrVuqGfrNmLX/6AyTdapEbUnH7uaO4xH
	 fMdH5oq8CJVA6J5e9xAye3Juh13Airto2mUcuH99JPPSLjQQ6+tCaPj7TCkwG5MGgF
	 kPGMbdlUnC47w==
Date: Sat, 19 Oct 2024 11:22:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Potin Lai <potin.lai@quantatw.com>, 
 Quan Nguyen <quan@os.amperecomputing.com>, devicetree@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Corey Minyard <minyard@acm.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Patrick Williams <patrick@stwcx.xyz>
In-Reply-To: <20241019-ssif-alert-gpios-v1-1-483eee5f99d3@gmail.com>
References: <20241019-ssif-alert-gpios-v1-0-483eee5f99d3@gmail.com>
 <20241019-ssif-alert-gpios-v1-1-483eee5f99d3@gmail.com>
Message-Id: <172935492333.3562529.4909443000024833728.robh@kernel.org>
Subject: Re: [PATCH 1/2] bindings: ipmi: Add alert GPIO enhancement for
 SSIF BMC driver


On Sat, 19 Oct 2024 23:38:04 +0800, Potin Lai wrote:
> Introduce the `alert-gpios` property to define an alert pin, enabling
> the BMC to notify the host when a response is available.
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/ipmi/ssif-bmc.example.dts:25.40-41 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/ipmi/ssif-bmc.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241019-ssif-alert-gpios-v1-1-483eee5f99d3@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


