Return-Path: <linux-kernel+bounces-176776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2165D8C34B9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 01:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EC3281F20
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631CD40BF5;
	Sat, 11 May 2024 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfZe9Mle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6917548;
	Sat, 11 May 2024 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715470016; cv=none; b=oImpdF29A2QI4MOGjTCEf0t832+hWgCxaA5NpMcVZw7KnCXvo9qQ3C0pWJ2OWDHSf6lw8rAkwOzeroLk8XAsmXWbVfglHpthgfUo0ntHkZRmXGMylzIwA1bnuHfVm/Hy+kBE3de8k0Dj7clRs3/DlK1zUc8o9C3HBiHS4xf2lss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715470016; c=relaxed/simple;
	bh=umH/195tM1jBPhPtzuzurdV4+4fFnQgqe6gFtyOmXQU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=CZoXjGHhuac6yV9Ewd4jQa8Qm1SVziB+LoS8ArknoWQFoDnxpV+8LntErvtRmB0EZknoTZ5CPtbSnVH5nlc7lLXUPB8oKvBSt4LeMLDsGI0juWaDxA/4Iv1MQfMmaO3h/NWI2kmOIOx92J4W8mKg2RRDFHTX/y3VUjBHImje/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfZe9Mle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3191C2BBFC;
	Sat, 11 May 2024 23:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715470015;
	bh=umH/195tM1jBPhPtzuzurdV4+4fFnQgqe6gFtyOmXQU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dfZe9MleHtBusQm+3pzvbYq663G5sgsVr67OHbfJpgov9fhExDfCvoEeOq9V0tEe1
	 0s9/w3yRr5b+sPoTrpwwsgMonhuezM3AczpBf+v16DG9wyQM+AFA0f/ShTV3bFo93G
	 OONxyD5cxXFwpMIdSnfLnK2lwhQHKP0S+vm3mDhJpqR969rLy/03I2EcIawCSyvNPJ
	 kNwkYyTgHljWX75dKwliJS58tTWiQFNy3dna7lFnaGzIhgT/pk5TuPOGfmcCwFXBth
	 WaRTFvH9gHIPnhv4fPuhSyjr/9fajswclNSre/FSOUk0ELjxiVM/GtHDqib4XruM5G
	 YB4j64j3u/wdA==
Date: Sat, 11 May 2024 18:26:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Xiaxi Shen <shenxiaxi26@gmail.com>
Cc: skhan@linuxfoundation.org, lgirdwood@gmail.com, 
 devicetree@vger.kernel.org, linux-sound@vger.kernel.org, broonie@kernel.org, 
 javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org
In-Reply-To: <20240511214739.242950-1-shenxiaxi26@gmail.com>
References: <20240511214739.242950-1-shenxiaxi26@gmail.com>
Message-Id: <171547001379.3047602.13405434982816987832.robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: ssm2602: convert to dt schema


On Sat, 11 May 2024 14:47:39 -0700, Xiaxi Shen wrote:
> Convert adi,ssm2602 binding to DT schema
> 
> The original adi,ssm2602.txt contains bindings for 3 devices
> SSM2602, SSM2603 and SSM2604. Since they share something
> in common. So I created one single yaml and name it 260x instead.
> Let me know if you think it should be done in another way.
> 
> It passed dt_binding_check and dtbs_check.
> 
> Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
> ---
>  .../devicetree/bindings/sound/adi,ssm2602.txt | 19 -------
>  .../bindings/sound/adi,ssm260x.yaml           | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2602.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm260x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/adi,ssm260x.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/sound/adi,ssm2602.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/adi,ssm260x.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240511214739.242950-1-shenxiaxi26@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


