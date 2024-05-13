Return-Path: <linux-kernel+bounces-177398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21AB8C3DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679731F22423
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F67D1487DA;
	Mon, 13 May 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="M4ZTeLUT"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D35F14830A;
	Mon, 13 May 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591895; cv=none; b=e7djJwwT45ENu6agpFWVlvpnJNyC8sLsFeRvJghs88ZCgDsqP3U3GGS8qhgjOuHHSLAf9W4FxT2EgOcyaCwQ0DBsP8tawSK6x7sf0boBy2auQKDkxdtZyhlylDsu3tGVQCMPE2+6syZ13fbyceRvBjfQVBYU65eRLsK8ivw/FTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591895; c=relaxed/simple;
	bh=H1wRpQDhNndfntcESpVSTwVBpeN3BYzfKza8GvHYZb8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okjpaOcDAYIp9PaaIA47Cw+2b+UzyMNVALgSNoREALHMnRzgFNRyltxKDYG6ANUNlNJRgshBLInrAxFri+CUWCGTEpLMU3k8skQcQSsETcit8S/ChWdoaHKehNEWIVwQ8o+9W/yuzOnMj58zQyi9XteoxqQa3FH7nMqNLdheh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=M4ZTeLUT; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 5634D100011;
	Mon, 13 May 2024 12:18:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5634D100011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715591883;
	bh=wZapPsm81sWCiMCo2QOM0XD4ZqQCOsyN3/ap/NfoDK0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=M4ZTeLUTnHAGKbsi8EMyDgPJ+KMRa5UGWyVdXe8U6TMkQsSIO3QwhnKaU8rvM/HIl
	 U0EO286kdWajQoTUbv+X9Sip2TtVRFHF0nDVv/ldOpzvtn/3uPbq+VWzKsusvWSlJb
	 6j33k8ws58WecZJa7GBZjopoQCLnM2yfHpJUHkDkFJwBTy3CgD77DPHj4jsPWnQeoj
	 GmOksgLAivMk4/TS6D2oYcWv/zbSbx+4u5oJG9Fy3+wa5R8UfG/dD+8JqOY8kG2zck
	 iWRQgK2NHRPP+cqPCEDMjs2vjjf06K31lvMJuWjFxxTfQIERRCO20rkK2gaH6U9auY
	 h8JuL38054OEQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 13 May 2024 12:18:03 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 13 May
 2024 12:18:02 +0300
Date: Mon, 13 May 2024 12:18:02 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Conor Dooley <conor@kernel.org>
CC: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
	<kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: meson: a1: pll: introduce new
 syspll bindings
Message-ID: <20240513091735.l3uewwzfrdd6qwbl@CAB-WSD-L081021>
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
 <20240510090933.19464-3-ddrokosov@salutedevices.com>
 <20240511-secret-barcode-e25c722ddf1d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240511-secret-barcode-e25c722ddf1d@spud>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185177 [May 13 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/13 04:27:00 #25181647
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Conor,

Thank you for quick review!

On Sat, May 11, 2024 at 02:08:03PM +0100, Conor Dooley wrote:
> On Fri, May 10, 2024 at 12:08:54PM +0300, Dmitry Rokosov wrote:
> > The 'syspll' PLL is a general-purpose PLL designed specifically for the
> > CPU clock. It is capable of producing output frequencies within the
> > range of 768MHz to 1536MHz.
> > 
> > The clock source sys_pll_div16, being one of the GEN clock parents,
> > plays a crucial role and cannot be tagged as "optional". Unfortunately,
> > it was not implemented earlier due to the cpu clock ctrl driver's
> > pending status on the TODO list.
> 
> It's fine to not mark it optional in the binding, but it should be
> optional in the driver as otherwise backwards compatibility will be
> broken. Given this is an integral clock driver, sounds like it would
> quite likely break booting on these devices if the driver doesn't treat
> syspll_in as optional.
> A lesson perhaps in describing the hardware entirely, even if the
> drivers don't make use of all the information yet?

Yes, it's definitely the right lesson for me. However, without syspll or
syspll_in, we cannot utilize CPU power management at all. I will attempt
to make it an optional feature on the driver side, but it might
necessitate additional conditions to disable CPU clock handling when
syspll is unavailable.

> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  .../devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml     | 7 +++++--
> >  include/dt-bindings/clock/amlogic,a1-pll-clkc.h            | 2 ++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> > index a59b188a8bf5..fbba57031278 100644
> > --- a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> > @@ -26,11 +26,13 @@ properties:
> >      items:
> >        - description: input fixpll_in
> >        - description: input hifipll_in
> > +      - description: input syspll_in
> >  
> >    clock-names:
> >      items:
> >        - const: fixpll_in
> >        - const: hifipll_in
> > +      - const: syspll_in
> >  
> >  required:
> >    - compatible
> > @@ -53,7 +55,8 @@ examples:
> >              reg = <0 0x7c80 0 0x18c>;
> >              #clock-cells = <1>;
> >              clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
> > -                     <&clkc_periphs CLKID_HIFIPLL_IN>;
> > -            clock-names = "fixpll_in", "hifipll_in";
> > +                     <&clkc_periphs CLKID_HIFIPLL_IN>,
> > +                     <&clkc_periphs CLKID_SYSPLL_IN>;
> > +            clock-names = "fixpll_in", "hifipll_in", "syspll_in";
> >          };
> >      };
> > diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> > index 2b660c0f2c9f..a702d610589c 100644
> > --- a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> > +++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> > @@ -21,5 +21,7 @@
> >  #define CLKID_FCLK_DIV5		8
> >  #define CLKID_FCLK_DIV7		9
> >  #define CLKID_HIFI_PLL		10
> > +#define CLKID_SYS_PLL		11
> > +#define CLKID_SYS_PLL_DIV16	12
> >  
> >  #endif /* __A1_PLL_CLKC_H */
> > -- 
> > 2.43.0
> > 
> > 



-- 
Thank you,
Dmitry

