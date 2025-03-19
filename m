Return-Path: <linux-kernel+bounces-567700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF8A6892B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662A6189CC35
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E46D253B55;
	Wed, 19 Mar 2025 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="mDtW64AW"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF86625334A;
	Wed, 19 Mar 2025 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379167; cv=none; b=Szct4eyQtLuf2bps7lFbiGr/kAMGH8gqsDP6+6KC7Lo5TDfRVK0EYsOMrcXDlwKCBlk8Nfp5THFIVs3d0kcbKNZtpkn6Dk4c1tfJgvf12eC4flabgSAgVbCdStWN4FMbEP9DdCJp9JO0sSaoWB07AFUKMMgIB+Kg2JuXOEfp33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379167; c=relaxed/simple;
	bh=AOQimFM4gJpZ42Ie2Z7N8zos6d6J3ZIO5Gx+iwOxWrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQc1i8oG7gMaapH6wiNZB3fy6cldxiuQfgxTZ+h0bnbWhehMPsv98D2vyc8xdv7voFTrf9hloP1ArkITupwEvRfTGYTxOyvl4xqNRpmilWGBAvq/dSMGPU7bO2oVs4tJllwz/VXv7d5ZjGWBEe2nxpo2qBEU5qWoFNY9mGm1kUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=mDtW64AW; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 534821FB55;
	Wed, 19 Mar 2025 11:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742379154;
	bh=je0ja3Jbbdo9i8hgQIkz3VZNqrQjX74LnXvU4ZmFaFk=; h=From:To:Subject;
	b=mDtW64AWkCAVnx7VshfU8wEZw5hqFFMwzuoGBJz2AXRejf9NEPKlgk1fLAW8IGUtx
	 evCeknxkmdsG9xjvYjZI+XdVO2RDAb2qrZquZpGZ9iSo8Dnwm66v9l9UrL/YeOCqVc
	 mrqtvjKfdUDl2RaWQEPfkBJp6mGHyrJw8k/DBxGoUFnd0p4lzx2kt/Wk1OUjugfVii
	 ijrFNCixFo9ESesvf8HsAQPxFexq4bybU/5wWpe6xxgeHpnDsF20D7Nn9gjqx5gkq9
	 SVyS9Di6eQzFiIish/OEx0qG94R99jKr20LYvlZcYQUrYNXh1JCGABSF63TkLTKgCH
	 wltYbqI5D6I8A==
Date: Wed, 19 Mar 2025 11:12:28 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: amc6821: add PWM polarity
Message-ID: <20250319101228.GA17979@francesco-nb>
References: <20250224180801.128685-1-francesco@dolcini.it>
 <20250224180801.128685-2-francesco@dolcini.it>
 <20250226134922.GA1944823-robh@kernel.org>
 <20250226135806.GA47264@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226135806.GA47264@francesco-nb>

Hello Rob and all,

On Wed, Feb 26, 2025 at 02:58:06PM +0100, Francesco Dolcini wrote:
> On Wed, Feb 26, 2025 at 07:49:22AM -0600, Rob Herring wrote:
> > On Mon, Feb 24, 2025 at 07:08:00PM +0100, Francesco Dolcini wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > Add property to describe the PWM-Out pin polarity.
> > 
> > Why doesn't the invert support in the pwm binding work for you? Yes, I 
> > read the discussion, but don't remember the conclusion and you need to 
> > justify it here.
> 
> This chip is not a PWM controller, it is a FAN controller.
> 
> The HW has a PWM pin output that is used to control the fan, but the
> device is not modelled as a PWM controller (correctly, given that is not
> such a device) and the OS does not control the PWM, the chip reads the
> temperature and decide the PWM duty cycle accordingly in an autonomous
> way.

Can you advise on how to move this forward? Is my explanation good
enough or some more clarification is needed? Should I send a v3
incorporating such a comment into the commit message? Anything else?

Thanks,
Francesco


