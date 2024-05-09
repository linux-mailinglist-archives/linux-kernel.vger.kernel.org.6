Return-Path: <linux-kernel+bounces-174270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B78F8C0C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6584B208F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06BE149DEF;
	Thu,  9 May 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sxGZlTxv"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D172BE68;
	Thu,  9 May 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242606; cv=none; b=ii5RCEU9w6usbxhxWDB0smlScfMk/w4uhduX9/4tMNv1M41oAefM8Pg8+v5QQCjU5LCn5sKU2VcxxOrPlwhHRrL906MCfwPhul4JhTDBAdFhcBzEVGm4qeatgzb7JAPhAY6PMVZJ91yo0aYr/L4MdPHGRjb5YB0DRACMxvnSn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242606; c=relaxed/simple;
	bh=X7epw5aSOTLIGrh7blDE9cGXX4BYffLBYQddCeYmmic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9yV+jDnBZuwi7mjvdG5a5HsDGZcN2Lkqat966pj9Y+jv+Nv9iMGHRi0hqKMGr1vnvAfbisgIYoZnkU0aPdPKt+0VCxzaJJeUxr9xYJKXiZsAwRVT6K8bZhXWeWdkZzT/0Wn+VgzhmVe2WBhfeHw9q4/sxR8eYo6HpIrhwpIRJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sxGZlTxv; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715242576; x=1715847376; i=markus.elfring@web.de;
	bh=PSf4fCDn3pPcXan/NtAB+ltaxCgqSeiG/PQ7cs7Zxgg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sxGZlTxvvCSbggYxyoCM8SgsH8mZHNKnttSL0KV2B2Ra3pTED+X3QLfmOJbNwT4N
	 iekHqNryruypJ9wW0Qyi+P9oufnR64MQUSpx3SCKryprfYMnvtUiT8gur7c8hbYp1
	 6V01FvIlbOjQ4b+jTG3wGYAjO8dQlhMWE9uUBUSLhi5rbGNAQjsDqbo4bgDu7YiZZ
	 gochJ7lkby9k4A41uqOqfC3z6TYkjwzhmbNeMGe/OODKUUZHN7anWIBYruD5e1bzw
	 66ge5W5IGL6zTp2IZI6uA5KfruD3p7IGvHg8RlYAizMaW0BKzmeV4IE/ad2BGM9OG
	 S5ge1u2GWyJG3Ir2HA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoNVE-1sOhiK1DAW-00hcqL; Thu, 09
 May 2024 10:16:16 +0200
Message-ID: <5886464d-a867-471e-858e-b4ed732a1d76@web.de>
Date: Thu, 9 May 2024 10:16:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
To: Yun Levi <ppbuk5246@gmail.com>, kernel-janitors@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
 <20240508192213.31050-1-ppbuk5246@gmail.com>
 <a407d12f-6845-4f51-a112-6bdc17641ff1@web.de>
 <CAM7-yPS6ecODhv-FQpYE5OE_LufmtKRg4htp9JH6MBUF03N4rA@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAM7-yPS6ecODhv-FQpYE5OE_LufmtKRg4htp9JH6MBUF03N4rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EXPGPfmSBCzrI02JHfq3EsBz/yJdoGC+c1lkDqBAWwxou2agASQ
 N8tjOFx5uCKeB0cyiMNDoBEu4Ij3S2XhSGNXYegFP5ngkgmKZU8uM5vhT6W8woUs8B4NNNY
 DUoM0QDocTwgiHJ3coVFKT4ykFvrSE7EnWIRzpdkHjg7UNytzh7f9L6WSn3UDk5+vRDDez2
 47H0TpX7VhOWg4MIKniVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i2RVKOL8xVc=;Ja2kiwmzbV3Yhi2E+4W4TfCzBsb
 Q70ylpFKqmuMmP8AF8bfRwBkrZE0L+iB0KuioKWVRiM+FpDjts+QqfeXhP7rPW+8GFjgTvMgq
 Ml6lhcqmGGa2OtFgo8/ilkPPXTiiMsvjZvtSlPD2iqcWvLnkNYAnOZ7syyVapN7y8Kwik2fU9
 rVYY1PWZQNHsEGohXUbwX1K2NFdeAQQcf5Lwz1qhRUXfoURQzE0O7hxpmgHBmp06BbeFwN7R6
 0vW+nrVJrBWC++UJsOwGH6cTfQEQ+qNpwTWAgtXoJPmj6AEjdtQUOR6dcCQIGeiDN7plDjMnb
 csZccW+UySBoHgg+gx4D+eYMEsNPJrdUeRe0AxX1+vH19GU74+hY4ODfGOgujoHTxYTt8qpQx
 vvwIaFdoZtC3/K9ArzcDN4z2+6cL7pnRl7ua54nRXytglfB6DKtX1TgkFc+lsd5n6QYDAE6Fl
 y4W8aXQwSQPQOUmVkQKtXr7S1Yay1dqA9KSfVb9wLOiD9PFAnHrEYHCs/0TQ6aRgKNlKi/cQ+
 9yuu7aUod5qiw//FUnchVP3/uvRbTzmcaQMdLlKJJ6iJ0WQTl1gVzJ0PXYW1VdsBw59Pnw1MX
 Zb1A41Oz8eHkiN7NKwRii1v4wz81NmCfGhP/CkeCiihYSMk/3HGhYxMGyBnfEzkSUzzrXRuNY
 wJ+GykFbmTW+oxWn5ZeTCX+i0zWlNDDcr6010dSDeIEhJKfauKfy6ems4UXhfYvtszZ9StzTF
 gAgX4gAy9CV6A6XrZ6XN0JWwMAEvb8vsvx/pcvq186p5T86Aa+u+c13SviKsGxvHdIcOW+mJe
 KShppq1Cq8z1hc0JvVZYG5EmbDvvYnjPeI5teXLGNA918=

>>> +++ b/kernel/time/tick-sched.c
>>> @@ -1228,8 +1228,10 @@ void tick_nohz_idle_stop_tick(void)
>>>               ts->idle_sleeps++;
>>>               ts->idle_expires =3D expires;
>>>
>>> -             if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STO=
PPED)) {
>>> -                     ts->idle_jiffies =3D ts->last_jiffies;
>>> +             if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
>>> +                     if (!was_stopped)
>>> +                             ts->idle_jiffies =3D ts->last_jiffies;
>>> +
>>>                       nohz_balance_enter_idle(cpu);
>>>               }
=E2=80=A6
> So, I think it's enough in commit message?
=E2=80=A6

We are trying to clarify special implementation details here.
Our corresponding wording preferences are probably different.
I hope that a better common understanding can be achieved also for
another transformation.

* Thus I became curious how you got interested to adjust this software
  component further.

* Will any other data representation become more helpful for the circumsta=
nces
  according to calls of a function like =E2=80=9Ctick_nohz_idle_stop_tick=
=E2=80=9D?

* How do you think about to stress condition ordering concerns around
  the system configuration =E2=80=9Cnohz_full=E2=80=9D?

* How will related changelogs evolve further?


Regards,
Markus

