Return-Path: <linux-kernel+bounces-362755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44A999B904
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 12:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EAA1C20BDC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ED313BACB;
	Sun, 13 Oct 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="hVvX2NRU"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291F12C54D;
	Sun, 13 Oct 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728813897; cv=pass; b=Mpo5tQfiZdrmETx0zY8QClzQ7zZVjXsUSB/HrlnHOwInJX13V2oKdW3kCjX0sGW0YRYz8mTvA87lZgARR/QR9tbnTo7dbGEeA3PDzjb++uxSx43XtnjCwBGwin85/XydWwpCrnCz6KFmUgtIiboypNnl0aU00mIGnnYw/9wRVgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728813897; c=relaxed/simple;
	bh=oowMGgvsSUKUqQmvbNYYKAxPF2sE/579CQdaH2P0nz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sbgm6l87/5Kf8lhV3Wxc/AV+/WIhia1goklGF4VL4YUXbkVgsJ/Ietiifk68GGoEPZgMA8Q+o//kIL52OOqUd6iaGlnsmrA619a79tJFqbaOj8NKpWOfa27D61RmwuYiBJbymLL6jwWnXDqhD+iNVtxIsxepotj15sSf5/CT9LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=hVvX2NRU; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1728813885; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YgvTr+PgJj9LrbkUSOjHmD6tdvmBExKM15qCESoZeZlAe97uLaIJ8H/RpNKNYRfupyHcwLBxegGwVeobtROlp+RylFmj2LR4AQsuCQd22O+X8CxAq7KsJem32LTcdvnsq7NDTfRS05WlBWg3OGBElSmVmiTGQShuxtC/C2DFtT0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728813885; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wkkHBr0u8fnHFJ7VpZD/I6fU+VrYj7525CWQ+F99E+4=; 
	b=O2PZWkdZV8VJOB3EWepul4LoWx44XqC9e3jfqGL/iP3Az7cme69IS2sV//otxLRSYRbh/BUybyOpatJHCftOCcOQV/D9bfRhkvNOkz2gmSANKLzke0S7lwHTxyTXboEXjPkrPGSYxYFzQ2YrthU/tfnLt3SioWhor8nwNoXYdnI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728813885;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=wkkHBr0u8fnHFJ7VpZD/I6fU+VrYj7525CWQ+F99E+4=;
	b=hVvX2NRUlrjdvgxxFJMg3UUadqRf7eNoSFEY5RcpyKUQzeOjnZIit762OWVFAM5/
	k37XyoxHEG2omeY/6pQP2t3fyzk0xP+qDJsWqrMgF2ve/8K3FOgtKMP/p+Iey149B3e
	jxOd/S+14zW9ovAYwmZzdB/bSxhYgpoKR/iD3mBmVck977o4JypfZuuH5+DMZkfJAu+
	eZ5BeYfS3FxMiOnY8YXgAm/J8TXpvuODBXfkd1gHYlF7lVIt/WCI7Jt1AzshyBofxxA
	v6e9oUkNGih3iptgEw1M3R1VciDfSlmb8C4jeLzSk3giDa6w0o9TZFbN2BZ+fFWxLQc
	d2M0Zr01nA==
Received: by mx.zohomail.com with SMTPS id 1728813882781587.9842715185621;
	Sun, 13 Oct 2024 03:04:42 -0700 (PDT)
Message-ID: <0c8264f56944c9e739bb494fd98df65b227ca30f.camel@icenowy.me>
Subject: Re: [PATCH 1/2] ALSA: emu10k1: add a capability bit for no MIDI
From: Icenowy Zheng <uwu@icenowy.me>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 13 Oct 2024 18:04:34 +0800
In-Reply-To: <ZwuYw27Y1YQy-DQJ@ugly>
References: <20241013014714.7686-1-uwu@icenowy.me>
	 <20241013014714.7686-2-uwu@icenowy.me> <ZwuYw27Y1YQy-DQJ@ugly>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2024-10-13=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 11:54 +0200=EF=BC=
=8COswald Buddenhagen=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, Oct 13, 2024 at 09:47:12AM +0800, Icenowy Zheng wrote:
> > +++ b/sound/pci/emu10k1/emu10k1.c
> > @@ -133,7 +133,9 @@ static int snd_card_emu10k1_probe(struct
> > pci_dev *pci,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err < 0)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
return err;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (emu->audigy) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (emu->card_capabilities->=
no_midi) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_info(emu->card->dev, "Card has no ext. MIDI
> > ports.\n");
> >=20
> seems like excess verbosity. there are much more important things
> that
> are not reported.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (emu->audigy) {
> >=20
> i would eliminate that, and instead populate the card table properly.
> that's a bit more code, but it's more uniform, and the resulting
> binary
> is even a tiny bit smaller.

Well in fact I just insert this here to prevent a re-indent of the
following MIDI code.

Well it could be better to be a=20
```
if (!emu->card_capabilities->no_midi) {
        The original code
}
```

>=20
> also, i would squash the patches, as i see no point in having them
> separate, given their size.
>=20
> regards


