Return-Path: <linux-kernel+bounces-431090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA259E3975
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0847CB2FDD2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ABC1B21B7;
	Wed,  4 Dec 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="GY+diCdh"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C31B0F29;
	Wed,  4 Dec 2024 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311800; cv=none; b=cSeJlmLRakjWomYidl5rmnprAku05EXbeeeIc6VPk0K4uJXpppNzHBQf8CReDb9PvZ6Bm98KH2I3gBEHD+1MAL1QT6rABKfMj/CBc6zNAwgIaeQNplhBCEsmAwf95sgxw/v/iZ+G3XWNmexM8RXznCYSLBo4gUeOsT0J1GygTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311800; c=relaxed/simple;
	bh=LmpkhL9MRG6gESO0icjsqbrD+7LMyFDJRUnvzWjJNqM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tqYJNrPpu0aJD1mzxb5o8uDoPmf17+Og/B0EnNvss1Lz94vxoPyB6c4bwcA40cLBaU6Uu2cvWz6zTt9uriW0SOTVguQ7AOAKLE35pvodX04HuEoQUsvsJulr8yC+v2Pei77FqgOW6mSz7AOCi1pE+WnNLzJlP+fFmN71J3Jx7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=GY+diCdh; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout2.routing.net (Postfix) with ESMTP id 77F8D5FAAF;
	Wed,  4 Dec 2024 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733311790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubIcwCWLfh5jAo1KxZIG7JzLEnZi0df0BVgjukgv6Gg=;
	b=GY+diCdhgkW/ExfA+Aj33mqmvLDQt6Ee1ZKpB5nHvp0ERna9nlzNRb4cNUoB2irPMQbpP/
	H0QsdiSMcaD+nPfx1XxaKPMMU6DE/ebuQXTdPzNn8D2rkR7869fDQrcDCV3JKr4KEHkMk0
	PiBdUYsTMxJbbrfbcFWbn3ntV3wxVRM=
Received: from webmail.hosting.de (unknown [134.0.26.148])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id E0E1C80238;
	Wed,  4 Dec 2024 11:29:49 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Dec 2024 12:29:49 +0100
From: "Frank Wunderlich (linux)" <linux@fw-web.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Frank Wunderlich <frank-w@public-files.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 17/18] arm64: dts: mediatek: mt7988: enable ssusb1 on
 bpi-r4
In-Reply-To: <79ac6523-b002-4e10-95ac-3df378f4f3f5@collabora.com>
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-18-linux@fw-web.de>
 <79ac6523-b002-4e10-95ac-3df378f4f3f5@collabora.com>
Message-ID: <3ab54dacf32dac008ff88855abb53415@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: ac671c49-9199-4ecf-97de-f969a38c05e9

Am 2024-12-03 10:40, schrieb AngeloGioacchino Del Regno:
> Il 02/12/24 13:25, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files.de>
>> 
>> Enable front-usb on Bananapi R4 board.
>> 
>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 
> Reviewed-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>

thanks, but i noticed, that the controllers in dtsi are not disabled 
like in my final dtsi. Imho controllers should be disabled by default 
and only enabled when used on board. Should i add disabling in this 
patch too?

and i noticed that usb phys have to be added to get working usb. Here 
for ssusb1 a tphy is used where i now have prepared patch so i can add 
it in next version (reusing mt7986 compatible). ssusb0 uses a different 
phy (xsphy) which needs a bit more work before (driver and binding 
change).

regards Frank

