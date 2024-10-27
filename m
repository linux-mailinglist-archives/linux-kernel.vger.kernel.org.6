Return-Path: <linux-kernel+bounces-383810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52199B2073
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813D21F21F32
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C3717E8E2;
	Sun, 27 Oct 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlNoq0eI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1513B558BB;
	Sun, 27 Oct 2024 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061527; cv=none; b=PwL1EpoATwqIsiqqigkF3QIZ7Y3Zzn0GRv5N3kqZJV2RXPmgX8+jiVB87QsF8SDM/NWdBUizzGw9Un4QP5K0ICwnh77cL4dYBKnv+k5zUPW57FbJkBcBFLlaYPWqKV7sSg3v+Sqe+G5xVTVWo22A/Ns/omWPnXUDryZkeDcix0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061527; c=relaxed/simple;
	bh=ktAYV2rb117r2Bc7owXHB7R3E7/79Vvp6m8NcDaF0pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5dE16zpM2QNTUv/2OYrJgFwnnH6s02kvatHWSEXnfE/iIpz9hNQGEHAQn7vnXJ2poF2mGTBv4DW6O0fRz6LOuC6rXZ+ZzpQL/krDd/e1OKYtYDKFVNYk6ts7L8Z06ThSIQoUksDiVJXztAvuzt/u01C3Bct3kSAqFOmSRTbdkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlNoq0eI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094DDC4CEC3;
	Sun, 27 Oct 2024 20:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730061526;
	bh=ktAYV2rb117r2Bc7owXHB7R3E7/79Vvp6m8NcDaF0pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlNoq0eIeeLHbFbBOqGqYn8aaRS2vepFibIKaPyafeUC84ZVVrrlVjLOgFJOF3uOr
	 IJCZefi8rdA6a4lO1HP3q1PRytsD8QMtSRVDIkLl2KC4eh6//fI0gV99kBke+AaCSh
	 kChXvp4uPjchdwlH+5hcrBiyXKmV4NRrmq1L7i65XPFaFKuGYHDjWnKmoKvUoWME5d
	 Rz/mUdgAwMFdlhWER1Vc2Wv4bacZRKt6xPvJdEwfZDUwB7k5P97pnqEwijjUv7YKTv
	 zQ10P6xb9JbbG4os1a3iBrOlNRM8FFdsGyDPlYacrStN3EJK9vTFGVYzUKYfMOV8FS
	 BJMiY7orvEBdw==
Date: Sun, 27 Oct 2024 21:38:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: pwm-fan: add
 retain-state-shutdown property
Message-ID: <ijdk5uuurnfd2shnwwj2nm64bno6lmrhdyqp42pzjc3i2e5cyh@v5ljkrsgo6ac>
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-3-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241026080535.444903-3-akinobu.mita@gmail.com>

On Sat, Oct 26, 2024 at 05:05:35PM +0900, Akinobu Mita wrote:
> Document new retain-state-shutdown property.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Billy Tsai <billy_tsai@aspeedtech.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  Documentation/devicetree/bindings/hwmon/pwm-fan.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> index 4e5abf7580cc..86a069969e29 100644
> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> @@ -40,6 +40,10 @@ properties:
>      maximum: 4
>      default: 2
>  
> +  retain-state-shutdown:
> +    description: Retain the state of the PWM on shutdown.

You described the desired Linux feature or behavior, not the actual
hardware. The bindings are about the latter, so instead you need to
rephrase the property and its description to match actual hardware
capabilities/features/configuration etc.

Best regards,
Krzysztof


