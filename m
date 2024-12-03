Return-Path: <linux-kernel+bounces-429507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3339B9E1D05
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4EF164E45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BAC1EF0BD;
	Tue,  3 Dec 2024 13:04:16 +0000 (UTC)
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDA131E2D;
	Tue,  3 Dec 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231055; cv=none; b=RvGj80n6sZhC2YpMXMSewEP34v9fcJeWlE6jtRiXpKatoEg7lvIZQjXqX4bqZ0Dwo8uANrUIuK6/KqpIc2sqzOJ2lzfSSTHykNZBvMQW5hjEe+SKkuXQDMR0+SLGnzzBs5s0r0p9q7IfDtp8AAYy+JF9ppH6vylb0Y1V2YAgI2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231055; c=relaxed/simple;
	bh=4Red2NtFdNCPFlrjhj3hdUEFF7Dn8UGMxBKxTlgNFyI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa5JT+ktWGuBdmiumQ1jgs8OCcXl0ONWGnvZghndiZ4yJzHnV6SvYOvbQz39/kr+VO880N7BE9xzO04w1XeXEV1I6xAB54n6xHVkucya7B6+mjLGE85Is73AJVM8HvfMxbFU3CGrzRu2hzwD8x8Kxk1Li5AG/EErMISvn7+EtB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 935553EDDF;
	Tue,  3 Dec 2024 14:04:05 +0100 (CET)
Date: Tue, 3 Dec 2024 14:04:04 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Luca Weiss <luca.weiss@fairphone.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: rpmpd: Fix comment for SM6375
Message-ID: <5qd74wbiyytgcn3k726jykm37ctahi4yd26vvhqea2rmcv6m6b@v7kcfhu3fyy3>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20241202-rpmpd-sm6375-v1-1-12a4f0182133@fairphone.com>
 <yo5cc3cvvwwdrqrrgwlquztj52sijip3ffyyqag55jrnztxi2m@hn75ylkhnxie>
 <D61WIF2XWKL8.MWU6PK2XGX4F@fairphone.com>
 <eovguha2tvc3rxd72yfqxgcg37waokoyqs377kvwmtdgssi4no@ii3i2bvl675i>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eovguha2tvc3rxd72yfqxgcg37waokoyqs377kvwmtdgssi4no@ii3i2bvl675i>

On 2024-12-03 13:58:51, Marijn Suijten wrote:
> On 2024-12-03 08:52:59, Luca Weiss wrote:
> > On Mon Dec 2, 2024 at 9:00 PM CET, Dmitry Baryshkov wrote:
> > > On Mon, Dec 02, 2024 at 04:45:02PM +0100, Luca Weiss wrote:
> > > > During an earlier commit, the comment from SM6350 was copied without
> > > > modifying. Adjust the comment to reflect the defines.
> > > > 
> > > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > >
> > > Fixes tag, please.
> > 
> > I thought for just a comment fix it's not necessary / desired.
> 
> Makes one wonder why the SoC name is repeated in a comment in the first place,
> when it is already in every named constant and the containing filename too.
> That's only prone to errors as you've demonstrated here, requiring a separate
> commit and discussion (and automatic backporting via Fixes:) to patch up, while
> it already wasn't relevant/useful for anyone.

Never mind, the filename isn't different, I glanced over too quickly.

In that case the repeat is still somewhat relevant as a separator between all
the SoC-specific defines in this file, even if the #define repeats it as well?

Apologies for the noise.

> 
> Less is more.
> 
> - Marijn
> 
> PS: That's a suggestion to see if we can perhaps remove these from all header
> files instead to save the copy-paste burden in the future?
> 
> > 
> > Anyways:
> > 
> > Fixes: 2d48e6ea3080 ("dt-bindings: power: rpmpd: Add SM6375 power domains")
> > 
> > 
> > >
> > > > ---
> > > >  include/dt-bindings/power/qcom-rpmpd.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> > > > index df599bf462207267a412eac8e01634189a696a59..d9b7bac309537cbfd2488e7d4fe21d195c919ef5 100644
> > > > --- a/include/dt-bindings/power/qcom-rpmpd.h
> > > > +++ b/include/dt-bindings/power/qcom-rpmpd.h
> > > > @@ -65,7 +65,7 @@
> > > >  #define SM6350_MSS	4
> > > >  #define SM6350_MX	5
> > > >  
> > > > -/* SM6350 Power Domain Indexes */
> > > > +/* SM6375 Power Domain Indexes */
> > > >  #define SM6375_VDDCX		0
> > > >  #define SM6375_VDDCX_AO	1
> > > >  #define SM6375_VDDCX_VFL	2
> > > > 
> > > > ---
> > > > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > > > change-id: 20241202-rpmpd-sm6375-06582e126d7f
> > > > 
> > > > Best regards,
> > > > -- 
> > > > Luca Weiss <luca.weiss@fairphone.com>
> > > > 
> > 

