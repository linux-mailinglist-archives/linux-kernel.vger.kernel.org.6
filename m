Return-Path: <linux-kernel+bounces-395075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00DC9BB81F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B9A1C24EE3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FDC1B6D07;
	Mon,  4 Nov 2024 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUzM/nFN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90F1369B6;
	Mon,  4 Nov 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731273; cv=none; b=MyALB8btX3QF2r4ImRvTuHbIX4ZG0oCZq0PTYrIGMHLLjRMpMYLnCK2tgxRz+wun64L8ikRzac/aVpbbXKkUMKqBDFA5LIFVE3QrfgQQ6CQcMJ7klyuCbNfJIMFIjsJWxo+M1r3gQBZ7yTey5vqdlUFF99lJsxPbAXIjRAWm1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731273; c=relaxed/simple;
	bh=RZqf7/lbIGoXx1+SMuA+O3AzMVC1PuJUuyLt5uaGs1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTFGvzCppHTrSLy8hg3/p/WGYDSMls85/YfcdrO56pOYRFF+UTeq6PbKOhxcghCatJUfmGKevOWZIkG10JtO3YzaDwLDCIHaHSLQUNoCKtTWggM6fAWMZYHzSUzy9Ncnrfyc15CBvIcDWLzjtNfi7TZcZwSPLbDMrLCdpIatLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUzM/nFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B36C4CECE;
	Mon,  4 Nov 2024 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730731273;
	bh=RZqf7/lbIGoXx1+SMuA+O3AzMVC1PuJUuyLt5uaGs1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUzM/nFNsoJg70EQnCf96Cw6/A5Vqyjj4EV06akSEfCzVDqVaItPh3WEJ5N2qZRJC
	 PkFA6LfEC7NfcSfOlO+hXqQf8UD1/uleUAuZeIc9R2WUWzEKgpXKvJF6pUOVBhnmLp
	 xUMF5tYMOKWPWzAyTVJd3lfrATR0Nt8Om3ebqesOne2GYiO1mhJZD3II1Jn7h7w4yY
	 MLBbEJEM6CX4AaWIuSSg2bYh7HLp3IBauqpesRVqufyhUBXcYBbN1RXvEX7NX/5pJl
	 n69HfgqWNJAt2rV8PiitU7lTZJpFwBMQwlp4POiMz2V8B7Fzpwb8hjWSBOl08GI4wK
	 lyXHhtuCLpbYw==
Date: Mon, 4 Nov 2024 08:41:11 -0600
From: Rob Herring <robh@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: rdbabiera@google.com, linux-usb@vger.kernel.org, krzk+dt@kernel.org,
	dmitry.baryshkov@linaro.org, conor+dt@kernel.org,
	gregkh@linuxfoundation.org, badhri@google.com, linux@roeck-us.net,
	xu.yang_2@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	kyletso@google.com
Subject: Re: [PATCH v2 2/3] dt-bindings: usb: maxim,max33359: add usage of
 sink bc12 time property
Message-ID: <20241104144111.GA4077878-robh@kernel.org>
References: <20241103034402.2460252-1-amitsd@google.com>
 <20241103034402.2460252-3-amitsd@google.com>
 <173061137043.3549002.17300495931303369678.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173061137043.3549002.17300495931303369678.robh@kernel.org>

On Sun, Nov 03, 2024 at 12:22:50AM -0500, Rob Herring (Arm) wrote:
> 
> On Sat, 02 Nov 2024 20:43:29 -0700, Amit Sunil Dhamne wrote:
> > Add usage of "sink-bc12-completion-time-ms"  connector property to
> > max33359 controller for delaying PD negotiation till BC1.2 detection
> > completes. This overcomes the occasional delays observed while
> > receiving PD messages where BC1.2 detection runs in parallel.
> > 
> > Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> > Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/maxim,max33359.example.dtb: maxtcpc@25: connector: Unevaluated properties are not allowed ('sink-bc12-completion-time-ms' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/usb/maxim,max33359.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/maxim,max33359.example.dtb: connector: Unevaluated properties are not allowed ('sink-bc12-completion-time-ms' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/connector/usb-connector.yaml#

This can be ignored as patch 1 couldn't be applied.

Rob


