Return-Path: <linux-kernel+bounces-561540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324C3A61342
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2386919C1ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4AB1FF7C1;
	Fri, 14 Mar 2025 14:03:02 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C11ACED1;
	Fri, 14 Mar 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960982; cv=none; b=Vr/ugK8NFHQWRWcjVQNf7Hli5n3CmIPAJBszIh4qYVK9nX8KkCvn+PetpBCwB3bhNYhY4aODCYSeHqp+Rk5vH8Gvjn/ce1WXNUEFjEYOxFs0GB+F+LSHNT7MPszDTQojOmy32hRHSaUcU9qKWBQP594Btggrev8lv4pUJk3dKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960982; c=relaxed/simple;
	bh=boNOdte+vJT175/MR4AKgqCkUXYM1E3voT2Jk7vJJJo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bjainSrqpthOxqrpp5vqQYcmx51gz+ooIEgXe72ghO54g68ABuaCIgRMCac23HNt+FB/bLkUpyPJ4bNsHwei5sr1VbOTHP2OT512YTF4Sgw7Vf8W2CTzEikQZ9a0k6CSEFSVhjIqm6yvi3bzVK3NWvtpFtbUN3zHUTIxGe92bG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.19] (51b6855d.dsl.pool.telekom.hu [::ffff:81.182.133.93])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000087004.0000000067D43712.0002C3B3; Fri, 14 Mar 2025 15:02:58 +0100
Message-ID: <678324f7a753bdd23337c87f49b4d651d4bdc3ad.camel@irl.hu>
Subject: Re: [PATCH] Fixed ideapad-laptop driver to support Yoga 9 2 in 1
 14imh9 unknown keys
From: Gergo Koteles <soyer@irl.hu>
To: =?UTF-8?Q?Ga=C5=A1per?= Nemgar <gasper.nemgar@gmail.com>
Cc: Ike Panhc <ike.pan@canonical.com>, linux-kernel@vger.kernel.org,
  "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Date: Fri, 14 Mar 2025 15:02:57 +0100
In-Reply-To: <CAKi4K-j-j_SdKOAvxSWeQ9qPN-tMVicQ_nbKkNDvm8rEsY_N3g@mail.gmail.com>
References: <20250313151744.34010-1-gasper.nemgar@gmail.com>
	 <4f1d9817-60b1-433d-b7a8-f37057e0980a@canonical.com>
	 <f581c3d25a270801de35b7d0380cbd13c4c4a131.camel@irl.hu>
	 <CAKi4K-j-j_SdKOAvxSWeQ9qPN-tMVicQ_nbKkNDvm8rEsY_N3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ga=C5=A1per,

On Fri, 2025-03-14 at 13:28 +0100, Ga=C5=A1per Nemgar wrote:
> Hello,
> This specific laptop has one star with s in the middle which is
> already handled by the driver and is assigned to key favourites.
> There is another button with only a star, I think it is ok to assign
> it to KEY_PROG1.
>=20

Ah, I see, this laptop, like a good movie, has multiple stars ;)

I think KEY_PROG1 is ok.

Thanks,
Gergo



