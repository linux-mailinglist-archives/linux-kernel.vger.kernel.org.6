Return-Path: <linux-kernel+bounces-251627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582F930749
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 22:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0610D2823B3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AC2143C52;
	Sat, 13 Jul 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VbeAEA79"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5A013B298;
	Sat, 13 Jul 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720902485; cv=none; b=NmdX4zlqKBTq2ImwSNHOUESRnCFr3eqAelLMDahmW9j4V0fwiyiJNzhBiD0olmJeJLAM6OiXdRb7qonouGL/363ixB6xxrAobXO40FeqifAOeUofRyFcwopVw5DXcoUImbF6M2z0InzKrFd+nklMjOPWqvMM8w3yFPV4vHYADWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720902485; c=relaxed/simple;
	bh=GyYXeQax5bvr9SaEKnOK79jymHiCKXBSVlIYVg+lYa8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KNQ0mNEJEJEeC5HxZ4q4eWgW80JRdTiAQylfR9btLTjkA2SFXaPfDj38tH820H1ubVK0paSaOlHfggQ8cLXgTi0noUFETG13IA4xC88oouEqhubU6Zr7bGJ5hvXCR9ZLOuuDuJV3IEMXIMfRhPeOjrUzhhO2tQJpQ/f4rvDToXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VbeAEA79; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720902394; x=1721507194; i=markus.elfring@web.de;
	bh=59vtINeooObPxm2tstgRG5kO8REGINXHS/RsBWgURMo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VbeAEA79n5pgEUV8dUsUG7HcO2mGx6/bXhwTYJb30VZevA93uhUroUiv+lVzvWiS
	 9MqoD4THxtuXSv0mCVHk3prdl1d4HvP8Ze7SQ8b6HMdpitBnr/btxfqHS3j9IfGDu
	 kdoM38XAn4HLdJr9tdbCX/IGJXS2PNYi13qZKRDoUhQ3AZ030GDi1oMVRtyA0vREg
	 hvrjNrkPl4yBS5359Z5hJfAOZMUGjbq0KuAUUPpXmHpw3ZOzeJwaTxduYl54WPLTX
	 zjMgzZv3yKHylpR3EGf/1IJ4OQRiLMGpggVbBkWx3Tlz1oiyH7YVkzo3zlcyZIxwY
	 BMWXZAqWIDYZMfSr+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUbo-1ruUyE0fvI-00fEAL; Sat, 13
 Jul 2024 22:26:34 +0200
Message-ID: <e194e550-e7e5-4df6-bda1-eb1141777ce5@web.de>
Date: Sat, 13 Jul 2024 22:26:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Babu Moger <babu.moger@amd.com>, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Reinette Chatre
 <reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Breno Leitao <leitao@debian.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 James Morse <james.morse@arm.com>, Jim Mattson <jmattson@google.com>,
 Jithu Joseph <jithu.joseph@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>, Kai Huang <kai.huang@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Kim Phillips <kim.phillips@amd.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Newman <peternewman@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sandipan Das <sandipan.das@amd.com>, Sean Christopherson
 <seanjc@google.com>, Stephane Eranian <eranian@google.com>,
 Tejun Heo <tj@kernel.org>, Yan-Jie Wang <yanjiewtw@gmail.com>
References: <81ca60c0029ba63fab7cfd6903ad115fad1d29fc.1720043311.git.babu.moger@amd.com>
Subject: Re: [PATCH v5 16/20] x86/resctrl: Report "Unassigned" for MBM events
 in ABMC mode
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <81ca60c0029ba63fab7cfd6903ad115fad1d29fc.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4VKPcy9BKyO3wlwqHfhubsuj18teIrK2DmC7+GAYcneG90fbvS7
 itFVvkvElIFiTmI98w/hY8xj+MndAD1S61/zgHTq/HWdUkbQ5QuJly4wrIculTWCywbIUP5
 GhSHWzoIbVeer/5B2RCiiFXsknH9QSZtY+QYRF5Lbubksko2fehMtNOLzbm9NGQllvUsCIz
 g2t7eapj1VBHvpKeJLkxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wiq64FJQqXc=;dhDTTXkDMTrB5nls6AJPpRgu5OQ
 cuFeOcvBcjncsQZnPx7CG0lV3Brcs+iz8ShYv2Ta2lfkNnyqnVTXHvDlnu/rQfRleMWjEbx+3
 3AiWGErVBnTwuZcKnPUxCoWK3vTB3yH/pP6NXdNIja6UfCdUCMAoAe3KZWsLEgYR8qSXaU6HF
 lyzsFR9G+f65cjVUpN/26trQ6qmXSQCf5A9CNJHzzksJLaWAG8lioWHLosZZ1mfvW6/UpWuoE
 sjuXo9kpM/Dcz6c0xbdOM67RZFcHIDijqTCnOvgxEYOaB1cLfCH8LP6m5pFlL1A1b7dc9y0g2
 hHreqG9Q+rQLGIDmUzttzpDfE90P3Kz6jPmhyOe2XR/1td2j7LWh13DdoMpdQ9Cu9yTU5aONJ
 MdtEBIGnicibur/sPauQ7pBG+lep5me8E1Y+uJtqwjrdP618WhIZLom3gyyv2/ZOsrctDxWII
 STX1GSH6SyjNGe47Bc/ZocEfEiZfvUnN6KIRWJe1VAPOB7EyhKu/zsmHYRq7o1uBKCQQQVakm
 z3S79WeoFhD2Bxt76Y0M5wFCV6bWOyAwYx5nRC6Nuv1xfyGoz81dPF+llROxMSVmDxAIAP1GY
 dntGdYcR8zJa50FOX9n6V96q6BgtYGVUVkGEu46zcobm9jNG+s3rBbz3nCG3rCAJX1oO7fxY9
 SJB02OqVG24gGI/owvsvMi6mwI9kU5xpVQ2B2o3z/VDw+K8CNf7IUj/oXKCNhS54y8MwyFHmY
 Z1eo5a1/+3Yi4C0uOTsCFoVNOkHzQGFkOwbMXEMZEgOeftZTXPrRu+CT3FZU4cgsKNp785j1O
 ehZjvby9LyQXmU1WTENsatww==

=E2=80=A6
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
=E2=80=A6
> @@ -609,12 +609,21 @@ int rdtgroup_mondata_show(struct seq_file *m, void=
 *arg)
=E2=80=A6
+		if (resctrl_arch_get_abmc_enabled()) {
+			index =3D mon_event_config_index_get(evtid);
+			if (rdtgrp->mon.cntr_id[index] =3D=3D MON_CNTR_UNSET)
+				seq_puts(m, "Unassigned\n");
+			else
+				seq_puts(m, "Unavailable\n");
+		} else {
=E2=80=A6

I suggest to restrict the scope for the shown local variable to this if br=
anch.

How do you think about to apply a code variant like the following?

			int index =3D mon_event_config_index_get(evtid);

			seq_puts(m,
				 (rdtgrp->mon.cntr_id[index] =3D=3D MON_CNTR_UNSET
				 ? "Unassigned\n"
                                 : "Unavailable\n") );


Regards,
Markus

