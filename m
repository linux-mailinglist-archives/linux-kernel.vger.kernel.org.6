Return-Path: <linux-kernel+bounces-576648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE45A71262
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C111917239F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC819DFB4;
	Wed, 26 Mar 2025 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="YwJTa9wK"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688EE282EE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976929; cv=none; b=fjbEmvqcTV5LSutzWNy7J4YUC1DVk2WcDEsnJRxllvjSvzEZ1rQ8KaQNARkvtFgFZ34RfRizQLG1cGkZh3rqcrKNL6XcvNRnQN2sscJma+oLLGG5okUbrwjC/23FnBeUxGoaSuA8zg2CuQ/IQQa8GC048lQIDUfKnO3Yj/DOMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976929; c=relaxed/simple;
	bh=59wg/mENGyNA1EgOTg7LDUTJPhVSFhKyoT9W6qQmLjQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LAKzjhr+LfI1DbpvZ5uNOzYQNnNk+iF0Yh+e0ZtXRVEy5QRxI9bKV3N5bYgOzta6t2RQHOhx0JEvveL3GAPe1GhbxU4ZfxmVKvKl8bejmqwQ5q6VabEkyhsRvQKCTloFxEVd5m1YxWRm4kLaMHUyr9y+oez0lFuwAGiZErSFVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=YwJTa9wK; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7xtjJXeFW/UxEZaJCI4G2LQ8dxt+s+2Os6jLAt+xnSY=;
  b=YwJTa9wKCcQd/e42GrLYPBZVOJYX6XkoguE3yRkMp3EGAIqQJQD+J+DK
   Z70fSjJgaftVoyCn0H+M2EHmx5+fVnjorGyK8LoryhPTjyo6os8uyXIa6
   JDEo0lQweA0IlsZwptPisyKPUPaTYfrAv4xrdQW3nr7ajdPL4eClRBKzE
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,277,1736809200"; 
   d="scan'208";a="112615683"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:15:24 +0100
Date: Wed, 26 Mar 2025 09:15:23 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Samuel Abraham <abrahamadekunle50@gmail.com>
cc: Erick Karanja <karanja99erick@gmail.com>, gregkh@linuxfoundation.org, 
    outreachy@lists.linux.dev, philipp.g.hortmann@gmail.com, 
    linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rtl8723bs: Rename variables
In-Reply-To: <CADYq+fa2T5k73ckaTgW36wM1BMNRQvYB+oO2fGYFOjvLH76WVw@mail.gmail.com>
Message-ID: <1dbf61e5-653d-2f1-25b3-ec4acff86f21@inria.fr>
References: <20250326072842.10344-1-karanja99erick@gmail.com> <CADYq+fa2T5k73ckaTgW36wM1BMNRQvYB+oO2fGYFOjvLH76WVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-628471745-1742976924=:3432"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-628471745-1742976924=:3432
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 26 Mar 2025, Samuel Abraham wrote:

> On Wed, Mar 26, 2025 at 8:29 AM Erick Karanja <karanja99erick@gmail.com> wrote:
> >
> > Rename the variable `mediaStatus` to `media_status` and variable
> > `lpsVal` to `lps_val` to adhere to Linux kernel coding
> > standards by using snake_case instead of CamelCase.
> >
> > Fixes checkpatch.pl warning:
> >         CHECK: Avoid CamelCase: <mediaStatus>
> >         CHECK: Avoid CamelCase: <lpsVal>
> >
> > Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> > ---
>
> Hello Erick, I think what Julia is explaining is that you should write
> your changes in v2 here where I inserted
> this message to you. Not to remove it entirely. Am I right Julia?

Yes, that is correct.  It should be here.

thanks,
julia

>
> Adekunle
>
> >  drivers/staging/rtl8723bs/core/rtw_btcoex.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
> > index d54095f50113..f4b19ef7b341 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_btcoex.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
> > @@ -8,14 +8,14 @@
> >  #include <rtw_btcoex.h>
> >  #include <hal_btcoex.h>
> >
> > -void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 mediaStatus)
> > +void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 media_status)
> >  {
> > -       if ((mediaStatus == RT_MEDIA_CONNECT)
> > +       if ((media_status == RT_MEDIA_CONNECT)
> >                 && (check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true)) {
> >                 rtw_hal_set_hwreg(padapter, HW_VAR_DL_RSVD_PAGE, NULL);
> >         }
> >
> > -       hal_btcoex_MediaStatusNotify(padapter, mediaStatus);
> > +       hal_btcoex_MediaStatusNotify(padapter, media_status);
> >  }
> >
> >  void rtw_btcoex_HaltNotify(struct adapter *padapter)
> > @@ -52,14 +52,14 @@ void rtw_btcoex_RejectApAggregatedPacket(struct adapter *padapter, u8 enable)
> >  void rtw_btcoex_LPS_Enter(struct adapter *padapter)
> >  {
> >         struct pwrctrl_priv *pwrpriv;
> > -       u8 lpsVal;
> > +       u8 lps_val;
> >
> >
> >         pwrpriv = adapter_to_pwrctl(padapter);
> >
> >         pwrpriv->bpower_saving = true;
> > -       lpsVal = hal_btcoex_LpsVal(padapter);
> > -       rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, lpsVal, "BTCOEX");
> > +       lps_val = hal_btcoex_LpsVal(padapter);
> > +       rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, lps_val, "BTCOEX");
> >  }
> >
> >  void rtw_btcoex_LPS_Leave(struct adapter *padapter)
> > --
> > 2.43.0
> >
> >
>
>
--8323329-628471745-1742976924=:3432--

