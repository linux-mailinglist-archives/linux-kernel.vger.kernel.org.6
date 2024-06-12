Return-Path: <linux-kernel+bounces-211912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B259058C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20372837A1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44BD181D09;
	Wed, 12 Jun 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwSWg0fF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E9181CEC;
	Wed, 12 Jun 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209564; cv=none; b=dfU0RuTdvorU8WXK1KaCWOB1RpWa2P+KS3VtKCuokGYW0jKP/jZXIWfSEVsRUgBtTmGuQ76DJbHj4V7obFt8TovKNZOdC7NfAo25jnVeUwUKrQjo3j69GSXvp6kfWCsCULSAuYEQtlgaUivSyvAmA8XjvcLTlnXXxIVzOvCI+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209564; c=relaxed/simple;
	bh=GRVneI/GUB+cNL6Bn2QY0NrLOqMobmZAtiBmgnkjscA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jIw9pA6vMUu063I6WTgmLGLqaGCDeVl2d/LKZprihPVs0ONswLnPSs27q5aBViSn4XfbBgOHsNpjTx9BUVPsP/79tUm9uA7YsuIQTDx03/TSchVT2/goyMKtupM9vNPeThmFK5ez42Aj08ATKEdKbSoPImve1GxSBgZBV/RgnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwSWg0fF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA4BC32786;
	Wed, 12 Jun 2024 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718209562;
	bh=GRVneI/GUB+cNL6Bn2QY0NrLOqMobmZAtiBmgnkjscA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=lwSWg0fF2TAhWv21YNzJKM8cxSNcF7HFD233OjZIHVBPam4H8Ci1pQR7L6WATznwx
	 /7TM/KAn6vIDlh/2tqAZcBYKy2aP8rssHk+IJY2d8R9nLUady2Au4F2jSULyavCSPY
	 96XAvDQCXy7kcK9U3OcVBXdBx0OIN0pKDYxqWmeFmXcYcrxN0o+IO0Pxd+GDgtpEIT
	 wbkq/nxRc6J40IqVRK/uxQDKyRFu+YXeSk1OnDucvKm9Ql8NIfi4ssPiuwd6r2OiNE
	 Ts4x6zA67L7hxWBn8b1cRK1h+wRqZghgIwRQ6cpE6Jna1SshkIX4PrpSm2/jpLCAVx
	 Iby1ioM1xtJvg==
Date: Wed, 12 Jun 2024 10:26:01 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
Cc: devicetree@vger.kernel.org, linux-sound@vger.kernel.org, 
 broonie@kernel.org, krzk+dt@kernel.org, skhan@linuxfoundation.org, 
 javier.carrasco.cruz@gmail.com, lgirdwood@gmail.com, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20240612145903.497758-1-abdulrasaqolawani@gmail.com>
References: <20240612145903.497758-1-abdulrasaqolawani@gmail.com>
Message-Id: <171820956123.2881078.5853703079167472760.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: sound: Convert max98088 to dtschema


On Wed, 12 Jun 2024 10:59:01 -0400, Abdulrasaq Lawani wrote:
> Convert the max98088 audio codec txt bindings to DT schema.
> 
> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> ---
> Validated with dtschema and tested against samsung/exynos5800-peach-pi.dts.
> 
>  .../bindings/sound/maxim,max98088.txt         | 23 ---------
>  .../bindings/sound/maxim,max98088.yaml        | 47 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/maxim,max98088.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98088.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/sound/maxim,max98088.example.dtb: /example-0/i2c/audio-codec@10: failed to match any schema with compatible: ['maxim,max98089']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240612145903.497758-1-abdulrasaqolawani@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


