Return-Path: <linux-kernel+bounces-274724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8543D947BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8B4281948
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D702A3839C;
	Mon,  5 Aug 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvsdwKyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D8118026;
	Mon,  5 Aug 2024 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864674; cv=none; b=AObLlv/9VzrkBCxztNIUEC1rLSAUVLMt9GrK/hUgYBkk8JuFbAGBnWkbBm09Sx0YxI/AT3auz6Fu2f2rH8GdeUGpH6NrrWKjn7SFnLwFKFvgozEeurkBbgI/2hmyM1CL64dUxf3RdvLeoZVhR5pOU0JhTtwuVvPtryp0a5Gz/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864674; c=relaxed/simple;
	bh=WPi7tZ555JJqoSl8/DBWHMoKDFJ5bJLdM8FFlQmnfoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsAofxpKaZtOfRI+VS/HVa03Se1Wo1mdqO6sT+LXNebsjB83L+EsitXU4wc2Rcx/5DO1QmgzBwTNy7Jah857mLmA7IYOpXvKdxEEiQw7t5hNbZj7GtyCh4KJW9tpGBtPytSUiM1yi4nYgncC4Sknq+bx0GqXmCfa5mKAvOif8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvsdwKyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AADCC32782;
	Mon,  5 Aug 2024 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722864673;
	bh=WPi7tZ555JJqoSl8/DBWHMoKDFJ5bJLdM8FFlQmnfoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XvsdwKyG4wEnvcwEhadorHEQCyCblUhzPYRnm6AzznysJAuMAiZyGS63TE+PirsCj
	 JboQGyJL5jI1NPVEQDMqmG5MjOHx1kxwW897u7pGwOk0rrnJDfh+yVjrJPLL/FKryJ
	 jYDiex0SY3ce9ug9UNvABnHFu810J0kGtACrHQWuC+lmRpgTuLXiuosStp+jywydNn
	 x62QHx92TPatqfOBYfAlbrGZ3c04fd4/wtdEp9eCLbHMl7vi+ESEXenYa2VEiguKaI
	 Wh1jsNSh3QeaEMNKlB7Jy6HXc1ap9xGBzH0spbycMdbXRyuGu6wQF5H+L+eMzvSDxp
	 j0+X0JuTCh0Vg==
Message-ID: <62652aba-fcbe-481e-8bfe-1eb0a22eba4b@kernel.org>
Date: Mon, 5 Aug 2024 16:31:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] dt-bindings: usb: ti,j721e-usb: fix compatible
 list
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Kevin Hilman <khilman@kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-1-8664bfb032ac@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240726-s2r-cdns-v5-1-8664bfb032ac@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/07/2024 21:17, Théo Lebrun wrote:
> Compatible can be A or B+A, not A or B or A+B. B got added afterwards,
> we want B+A not A+B. A=ti,j721e-usb and B=ti,am64-usb.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

