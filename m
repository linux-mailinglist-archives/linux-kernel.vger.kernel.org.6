Return-Path: <linux-kernel+bounces-552566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F23A57B6C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271EC7A4565
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441821DD886;
	Sat,  8 Mar 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6BOypwo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957CF13DBA0;
	Sat,  8 Mar 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741446365; cv=none; b=gr6fL47E/IPp4q2u3WevJpbv3Yk01gm7OEL9Dk9G1PDVPEaOGy88Zd5h3koXOOxcY6Vn5hBXF3CvV1ZXFC59KWd4mZXj+H8mUWFhKWzgdLngHJcedSYAcXce4j8NCTfJeOqYiZqbcVXUJ8oCYRyP+rTneKpkljkT9GIL0TmsNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741446365; c=relaxed/simple;
	bh=0vY585rBS4K/kQf0IrbVaYI2Pui+QDf9xbdm7a+DlMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nnj/24L9DjS2LwJq01SgWbldyh6x75/CkXMJLBoCd9/qehdcpu9TcFcl4vTSoj9R7k91PfV1YvsKBFg+7bityVCMp/p6TKS+zy7SYaTqpoD4t0qTapnpGbjLJpTxlr8pMdjCY6F3yHo56wxITC2RpggvH8SUidNKK56bw/ZsbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6BOypwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCB0C4CEE0;
	Sat,  8 Mar 2025 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741446365;
	bh=0vY585rBS4K/kQf0IrbVaYI2Pui+QDf9xbdm7a+DlMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F6BOypwo7TKzBj/xMDXU1W8G2pc6rnVrKOA/qsAVdDBzNyMNaSwSr646Vvz6JmaRW
	 St8CDET/tPzr3euAivN2CTu2M5T5NU5bohSx6fcp9cG/vLMKRPp/da+IWHKhol+Vu0
	 Lm4dhhJP6PhWnN4U/zRVaCECP82YVHP1CC4ly62IxKlaDWNopylcB8GdvxnEWdmJST
	 Vvwq9bclprskEXzrRLclVv/o6fliW2kKUP9stly4gnSNHmcWfEGdyATu5NJN8RCImx
	 Lp9MHpeffRkhKmCAy7Pm3OW/6tvwR76BX8mDs08b+pq4d/6444cAEj+FEqn2wcWjrM
	 CbWHXzAF/slxQ==
Date: Sat, 8 Mar 2025 15:05:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <20250308150555.1aa46abe@jic23-huawei>
In-Reply-To: <20250306-promotion-tarmac-bc5172f38f31@spud>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
	<20250306-iio-driver-ad4052-v1-2-2badad30116c@analog.com>
	<20250306-promotion-tarmac-bc5172f38f31@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > +  vdd-supply: true
> > +  vdd_1_8-supply: true  
> 
> You're allowed to use . in property names, and the _s should be -s.
> That said, vdd and vdd 1.8? Shouldn't both have the voltage in them in
> that case?
I got curious and opened datasheet.  Only seeing two supplies (vdd and vio)

So checked driver and that doesn't enable any of them.
> 
> > +  vio-supply: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
Supplies that are not actually optional (i.e. device can run without them)
should be in required list even though the regulator core will provide
stubs if they aren't in your dts.  The aim is to reflect what should 
be provided, not what Linux does with it.

Jonathan



