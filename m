Return-Path: <linux-kernel+bounces-367743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A39A0627
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB1C284D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14ED206961;
	Wed, 16 Oct 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Je2FlEoG"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9F1FAF17;
	Wed, 16 Oct 2024 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072505; cv=none; b=nb7i2TXof2t71O0oyUfZQCOpiozFmuqyh1D1DDphtNWWDIknNEWSgT+II2grXdQXU30I1iuErc6j1MUhNdIaksVumo6+A87KRRsNZ8kpcwo/nGOAFZPxSoilIOc2hVDBMUsBGoDEpYngU0mT4Qh5OKEeBEXvBUb/hqgs2I0cSzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072505; c=relaxed/simple;
	bh=B33N9NCktEKQzY6gUrpC2zYWEtyfJKfOrZV2IutPllQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfMEX2myv9oE3BWzNybQghbw64hRq+nVfOV8pcqPATn4J/W8bDm22qYWzqbROepabEbBKfK0VxK1Fsk30Rt4W+kst17rqInH+nscp9CCH7KWO5Zd47TwU4waWAz9QKRjtMCV/mqW52+M/dx0gfLI/nUs2ZrG8AmcYMsyY2vItbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Je2FlEoG; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729072459; x=1729677259; i=markus.elfring@web.de;
	bh=B33N9NCktEKQzY6gUrpC2zYWEtyfJKfOrZV2IutPllQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Je2FlEoG1wn1fI2boLzaSCHA9EUoNF+dLrvNmQVKhwvyLQaab6SDfCTOC7HeVHmh
	 nhYKmAi5n/f1lkTKGFmbMuck4ek6ag7oyTa+dgjf+Ek/v5tJM36FMXypYT8lqokBM
	 J91tjrKBcnlxetSDpRYbGDMAiD6+hOtgmGW03ADO3jbvoYeN2M5LcUf8E09Zobutg
	 jJqZtAqssIzuEvLcT06PUQZmJ+T/NazeSZIxtFovPF0m7prsfhhGWy/m/PkODpuWs
	 Ke8Zd4UuO0N7xca3w7dHvEIaLQBUk1He+8RaAhGyjz3HoJ/6BO8lX1jSJTPwk6Z/q
	 DE0enNNycmOFXgIr1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgNS-1tDiK90UFO-00Dmjj; Wed, 16
 Oct 2024 11:54:19 +0200
Message-ID: <42c7dfe1-451b-4f70-8358-725cf3eed549@web.de>
Date: Wed, 16 Oct 2024 11:54:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
To: Thomas Gleixner <tglx@linutronix.de>,
 Kevin Chen <kevin_chen@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de> <874j5ddow1.ffs@tglx>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <874j5ddow1.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5PdP4OeLPruXhve1TsYeyQlvYAJ06iKJriezhlJsCtBxNnKyTNx
 tNA77FMgapaBdZdjEsYh5tNukeEBponwO2/mdM2WRXYPipqo6efWLIslsPF/dmaBgTgIIHG
 9blNFdTKuFT41sDFmnDzkCWjPZDuGGIFPMhj00W4i5aTQxEaNeisM5aBtn3C3aDSAHnMT03
 5T/ms4ppv03+sfNzkZBWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GDpmqTIObF8=;P+X0BK25UKhmiTH5Wz/6TTqcklE
 C/eBsj8x2ZwmC5cHvXLA49jMiMcLY12hG2naqPWceqI67SY/+2ao69O+zfdvI6GyL5qdgFNKa
 LTgbjkxJ0ViOaR9AhJE3ImYx/Peh7TArul5Gwsmtziopxz/OsXTjTUgLQMUirnBJ3oC041jW9
 5cwMh2+qy/PK3AMzdWI5z9MAiGv1jywQDeoSjVO2MCqmo7mi86XIe2yPUCQ3BT5eYLTPM/Izh
 L53gJC5EG6dSRPnEuoanGBLnVPgBVEYd2Xyhi5TeUtXzW+zA6qlJwzdr2bjRheOcfpAnYBxnZ
 rmbnI3qUxbV2LK9C0iA3uqO14ASDbLnzZf184D9bSuIRysOwf5Kt8Ge+qBUtyqfB+8Uwt0/RT
 EY6AzoCI9idnxpm6tdLdWucU0vp6b5BaAtXKFH9gszMLuxa5h+9lsZbmJISl6BWhz1Pri6Nxl
 MdkBSew4sMwG8l/JB+GTlLlGYjbjCaBWwb6DxIfN/uxoGVgrm1aN3euOwZxkBh+p+AWORUOKC
 svcwtVudNFGDc7q+1qQXRhEvj/VITCbs95AeQrTjQNSGFjVGTOaH6k7717UuKb1S/SaHVknrK
 yjU4Re6IsAGhWDmBjJWXLNevczVm9dHuZgKTu24WK508oyp3uH8FbV6H5uMxzhv7+/BY36exo
 JwvR7ytBkatPki8VqYeuvnVd8v7dZ7+FKWp67ZvcWclXsJ/jO5eTIeiAkkTH188V5vfFmT0Nu
 HUIlA69XcqeZT8c0ZpIMEy2c/KV3HhH/2N8060jNdHqUJI0F2u5fJdaCYSrk8nc3Zdx82sE0M
 FANtqddy42xjvhpS1AWw92nw==

> Making a guard variant of chained_irq_enter/exit needs some thought and
> a general plan for cleaning the whole chained irq usage up. It's on the
> cleanup list already with quite some other items.

I became also curious how API usage will evolve further here.


> We are not adhoc adding a guard variant because guards are hip right now.

Application interests are growing, aren't they?


> And no this does not need a scoped variant ever.

There are subsystems which seem to prefer such a programming interface occasionally.


> guards are not the panacea for everything.
Their usage might become more popular.

Regards,
Markus

