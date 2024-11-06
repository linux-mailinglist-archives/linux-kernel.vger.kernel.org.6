Return-Path: <linux-kernel+bounces-398337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A19E9BEFCF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4681F218F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B275F201016;
	Wed,  6 Nov 2024 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESGYYYcP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8717DFF2;
	Wed,  6 Nov 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902051; cv=none; b=Uu9klC6UEQ+aNJfWNl4E5W217kCIudkj4ByE//X7OCUyKmshHuoS2tPJBXrVnPe4YY4O/Xe/HEQTNzfQs8Z8X953zRLgPVl9wpFrLlihBYZ4BbQBAEpJbMrVbmtVUH/4J8TA5J3IEE33kLD4vcKWe81WC6Gje+2F9sPC7KnuYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902051; c=relaxed/simple;
	bh=w4OAi8NjFxBZorVugcH4X3mQGwmGxL5wruUiOZSVGJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHM4jTsF42Ot8pfxLBENJSquqH8bjXnPzaeM1NdBY+1lB3LWXJzs8ziTVeNY632C4SvxLItJyM71fkNl2TCcBJZ0/pfGzJ/fQ91gYEI9txKko+4fdRoh3wsylpQgVldTFwS+h6zjVJQ5HNEf8FbmoJpalp8KpOSaGlA+MV6/szk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESGYYYcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C23DC4CEC6;
	Wed,  6 Nov 2024 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730902050;
	bh=w4OAi8NjFxBZorVugcH4X3mQGwmGxL5wruUiOZSVGJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESGYYYcPVGLc37OasmV/0YXPuPkpGfrvnDYki9so8a2he56OhSyfWZ/jrHZ1Igawb
	 BoWb6Iq6tgaix2JKbJ1WtEq9RtZXToXIMd9jQptPqWc9xR28u9gUxTeayqYQkz5TeD
	 tsHUPSbsKbA5MEAH614BVK6IdH651uH8BK83dbjoA2+joGIXKJ946eIRNj//yO/Dz3
	 t5CJOq3U2HKN0BIMlfCNE06AcEY2+Tx2IdruHio4VAzmkFA9OCTq53rCikp3yhoMen
	 9io0qb1RlSPTRwUBfrZZtSxly+DpsvXD6pvYInBskjz0KZwKzYPPgK1tlYuL5TbVNS
	 LjWZY69N/U4vA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t8gh1-000000004tY-0Mhq;
	Wed, 06 Nov 2024 15:07:31 +0100
Date: Wed, 6 Nov 2024 15:07:31 +0100
From: Johan Hovold <johan@kernel.org>
To: =?utf-8?B?5ZCz6YC86YC8?= <wojackbb@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add MediaTek T7XX compositions
Message-ID: <Zyt4I2YFx5lm0cLi@hovoldconsulting.com>
References: <20241028080415.697793-1-wojackbb@gmail.com>
 <ZyDRIW0DIGn_FIsD@hovoldconsulting.com>
 <CAAQ7Y6ZGrQt+rPBK9PzwJRC5ErbFgbc239X=iwjRboY3HU6O8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAQ7Y6ZGrQt+rPBK9PzwJRC5ErbFgbc239X=iwjRboY3HU6O8g@mail.gmail.com>

[ Please avoid top-posting. ]

On Wed, Nov 06, 2024 at 07:09:22PM +0800, 吳逼逼 wrote:
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> It is USB AP Log Port.
> 
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> It is USB AP GNSS Port.
> 
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> It is USB AP META Port.
> 
> I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> It is ADB port.
> 
> I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> It is USB MD AT Port. User can use the port send AT command.
> 
> I:* If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> It is USB MD META Port.
> 
> I:* If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> It is USB NTZ Port. User can use the port send MIPC command.
> MIPC is an instruction set designed by MTK, similar to QCT's QMI
> 
> I:* If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> It is USB Debug port.

Thanks for this. Please include this in some form in the commit message
(e.g. a table listing the functions).

> Sorry, I don't understand "not accepting modem control".
> Should I set the non-MD ports to true?
> for example: USB AP Log Port.

I meant that you should mark the interfaces that reject modem-control
requests using the NCTRL() macro similar to what was done for the device
with PID 0x7127.

Johan

