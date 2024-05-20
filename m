Return-Path: <linux-kernel+bounces-183435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF458C990A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2070AB2121C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 06:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236817C98;
	Mon, 20 May 2024 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th4+0sJt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08211CBD;
	Mon, 20 May 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716188021; cv=none; b=SGm0UiHjsvcIrZB66u+RllIdLQqbspdjJGOthZntV4Yk49KPg9iSsysiB4mZgGRHyboevxIBt4uRmIQ7qPJxerOLz//W734bEszWLvexxc3iQnR3nPLy7yq373Nec/neaX5a67OqcUcbhmVD06EQTD7RjMXez+OhckByGsF7BPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716188021; c=relaxed/simple;
	bh=aPvTGHmzC1tXHmnngIXATFIBNFjt3c0xS48WD1tiMWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4HfbCjdBA2f/4tWpyQ93dmZqk5V25tVQK53IaD3axCbmhE6qtgRiQhhwPvGdcN9Wuy//KMALGyuHIVnh2o9TQl8CYm/IuESri6zOgv2ToGNM0br+wKGkRr0oc9mFZwSBCDFsTF6woXaFxSenPn+aTHjmB31MYCJ6DGMelC/ZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th4+0sJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144A5C2BD10;
	Mon, 20 May 2024 06:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716188020;
	bh=aPvTGHmzC1tXHmnngIXATFIBNFjt3c0xS48WD1tiMWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=th4+0sJtVygM33NaABakHg38X9Xbba8bwnjHhtuujEeFDwpn/qrnkSEsUJmAWwH86
	 3wbs8UASoAetagi0Kw1r+miJCNRENfm+GBPAjv3N97L5QOyH4UGSJ89c/1rPcRJ09u
	 F0SgOcpsx9R5rxp/nvqhH91fjCZ9pgCAvIfJeckLZQIJQejlFQDnwn/2XwN7d50BRy
	 lJoL+bIzetw1mldMoBjXWp4C3L+OdYhG7IryGN/g/RriSYn+eBwnvYxrQdAUm+GUL0
	 75MXfCluPbHeHW23QBEeJmw+XC249zMwvJx7NN7h7mKVNtmkvZRgirM3dhq+OUj09Y
	 8PBEgc7LT1sAw==
Message-ID: <469be7c2-6865-40d4-bd06-15dc3a08b3e3@kernel.org>
Date: Mon, 20 May 2024 08:53:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: gpio-sbu-mux: Add an entry for
 TMUXHS4212
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Parth Pancholi <parth105105@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Parth Pancholi <parth.pancholi@toradex.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240517111140.859677-1-parth105105@gmail.com>
 <1675a33d-47af-4de9-a0e7-177cbe208e2b@kernel.org>
 <20240519202754.GA3334@francesco-nb>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240519202754.GA3334@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/05/2024 22:27, Francesco Dolcini wrote:
> Hello Krzysztof,
> thanks for the review.
> 
> On Sun, May 19, 2024 at 07:38:07PM +0200, Krzysztof Kozlowski wrote:
>> On 17/05/2024 13:11, Parth Pancholi wrote:
>>> From: Parth Pancholi <parth.pancholi@toradex.com>
>>>
>>> Add a compatible entry for the TI TMUXHS4212 GPIO-based
>>> bidirectional 2:1 mux/1:2 demux which can be used for
>>> switching orientation of the SBU lines in USB Type-C
>>> applications.
>>>
>>> TMUXHS4212 datasheet: https://www.ti.com/lit/ds/symlink/tmuxhs4212.pdf
>>>
>>> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
>>> ---
>>>  Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Where is an user of this?
> 
> The Linux driver (drivers/usb/typec/mux/gpio-sbu-mux.c) is using only
> "gpio-sbu-mux", just in case you did not check yourself already.
> 
> As of now there is no DT file in-tree using this new compatible, FWIW
> "onnn,fsusb43l10x" in the same file is not used by anybody. From some
> old discussion here [1] (not exactly the same - I know, and coming not
> from a DT kernel maintainer) I assumed that it was fine to send such
> a change.
> 
> If it's not the case we'll send the patch later on, however some
> DT files maintainers (e.g. arch/arm64/boot/dts/ti/) have a policy to
> just accept DT file in which the binding changes are already merged
> therefore I was trying to be a little bit proactive here.

TI? Never heard something like this from them... Such requirement would
seriously slow down any work, so it's not really reasonable. Expectation
is to post both binding change and an user, so DTS, in case of USB in
separate patchsets.

Otherwise you will get such questions, so your biondings patches also
won't have easy path to merging...


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


