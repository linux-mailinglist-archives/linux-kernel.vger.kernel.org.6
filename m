Return-Path: <linux-kernel+bounces-331936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A049397B329
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72ABB282318
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1676517B4F6;
	Tue, 17 Sep 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWk6coou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1DD2EAEA;
	Tue, 17 Sep 2024 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726592125; cv=none; b=hs2f/jgK6F03MISPiUtpqi+1UFbjOQh9WJj2mZmVxtc9+7WEaWBOLqX+Ml3s9K1CgthpB9d+5y/doR+V43wjZQqaHBx02D4cbOGezoVT2tcP+s0zHAmjV2uVe/dSxVTe7WJ/r2OJb/H07R0gM2KJ7LBRIZgBX6MZvid+TOHBQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726592125; c=relaxed/simple;
	bh=AYkc77Maz/sVF6DUda6J3CIh2dCKMgXWRxg4il5DkVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laofxPHqiY+0pdeUC70Ut0ixDTA6hAhhN4mOFWCKlepIRroKixaFogiIzyxnHZGgzSekXrbGv4/bU9vztrn+E9i7EeN6gmXk7UtRq1xJ/A08AiQexBFc7yZCXFGU88+D91vCIcirJYugNQc9orVSHtc3d22NDNQc8VzSbrlqqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWk6coou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE9EC4CEC5;
	Tue, 17 Sep 2024 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726592125;
	bh=AYkc77Maz/sVF6DUda6J3CIh2dCKMgXWRxg4il5DkVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oWk6cooucaEaqPyQxG1RCP8SAF5o/BZvqTv0J4oYYDHdK1nVAwUrSCumIp8WO1s8c
	 mmHHe3sfod2/A3NYLGN1m+qKz/x2WYaZIOKFJ5aDEt4Gh/3wTHxrax1ZNdtEx5PQYN
	 qmoM0AipB5GM7P0Q42JT0DXMAtEXfsvC0wcCMu4piUe9hJzxmmNvFmvde7iwAnW0ad
	 W+4MEGC+Z6RZeGH9LmUKAgYPRrDWcLRX1QuSndkhIdZiq/CthaAIYramZzNQxhR2Z6
	 Q1Qj0JxK1WpvsmWQzxTWxC9GCVFWHzIHIzJ6wIdqLuGSNCmBk7Mkk88+mGBvnyzur9
	 FrugcbLwoFq2g==
Message-ID: <b0cd6a5c-9dc2-4ca6-a526-104788edf581@kernel.org>
Date: Tue, 17 Sep 2024 18:55:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] regulator: max20339: add Maxim MAX20339 regulator
 driver
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
 <20240916-max20339-v1-2-b04ce8e8c471@linaro.org>
 <29f30aae-ffad-4a42-909e-b05f9cf360b5@kernel.org>
 <ZulFBQzRdOdw9cfV@finisterre.sirena.org.uk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZulFBQzRdOdw9cfV@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/09/2024 10:59, Mark Brown wrote:
> On Mon, Sep 16, 2024 at 10:06:37PM +0200, Krzysztof Kozlowski wrote:
>> On 16/09/2024 18:48, André Draszik wrote:
> 
>>> +	/* INSW status */
>>> +	if ((status[3] & MAX20339_VINVALID)
>>> +	    && !(status[0] & MAX20339_VINVALID)) {
>>> +		dev_warn(dev, "Vin over- or undervoltage\n");
> 
>> Same with all these. What happens if interrupt is triggered constantly?
> 
> Logs on physical error conditions are a lot more appropriate than debug
> logs, they should basically never be triggered in normal operation and 
> often it's a priorty to get information out about a failure in case
> someone might actually see something going wrong - especially with
> regulators, the system might be about to fall over if we're failing to
> regulate except in cases like SD cards.  However in the case of the
> regulator API where you're telling the core about the error it's good to
> defer this to the core.  We should probably be doing a better job here
> and logging something in the core.

In any case, this probably should be dev_warn_ratelimited.

> 
>>> +	if (val & MAX20339_LSWxSHORTFAULT)
>>> +		*flags |= REGULATOR_ERROR_OVER_CURRENT;
>>> +
>>> +	if (val & MAX20339_LSWxOVFAULT)
>>> +		*flags |= REGULATOR_ERROR_OVER_VOLTAGE_WARN;
>>> +
>>> +	if (val & MAX20339_LSWxOCFAULT)
>>> +		*flags |= REGULATOR_ERROR_OVER_CURRENT;
> 
> These should be notified to the core too, especially over voltage.
> 
>>> +	irq_flags = IRQF_ONESHOT | IRQF_SHARED;
> 
>> Why shared?
> 
> Why not?  In general if a driver can support a shared interrupt it's
> polite for it to do so.

I explained why not further down the context: because with devm it can
cause resource release issues. I also poke if person added it on
purpose, thus knows the answer "why", or just copied whatever code was
somewhere.

Best regards,
Krzysztof


