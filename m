Return-Path: <linux-kernel+bounces-224890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14853912841
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5446281880
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26052C697;
	Fri, 21 Jun 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lRVwGJme"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C661C6BD;
	Fri, 21 Jun 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981098; cv=none; b=YtnhOekIq3x95E6TTgcpn7Vi5XBjBj/ZY5filgzsz2a5QMLMmd3exuDZ05czvIN66jzNWY2JgxNzi6rptnuJnF4EaxngKihOesLBNAy0nMjIQdk6hh3t68MnKkW6TepfU7f6DwOaKmZAhiysZqH6EQfSE8l60kX5TCZd+bzyEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981098; c=relaxed/simple;
	bh=UPZ+pMVVIZt6Rgz1oxI221a1QLWLiy8Gw1463avvxI0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NPK4dfZhAk51l74LILRjUGmgkanoBMTJHp2gLN21TJqEJTsyBEyLPF6S8jBofhTatOFZvfIMzRZqc9J96nrJreviiM5grulDXxMLZgIpom0rU4SbJU7GlYL1BoaaXynYYqvv0Z0ZRNgGIgQ24YzkbAk5CVyMpCHYSBYQ/OZHoyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lRVwGJme; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718981023; x=1719585823; i=markus.elfring@web.de;
	bh=SN7RlCBIZ8lBMty9UKSUkIU0BTJtq+6R+JLHTgaFfAM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lRVwGJmeZRzMJV7WZ7bhrXq7ofkQ9jwqWb+//R8p/A8eMX5aFENhPNDtTBcJjanC
	 aF+ODxRvb/CRMtYV1nf1doefZGI4s0h9YbqYBuQ0ryCgRWZoJ3Zi4NNq3Arngs5n+
	 FTV9QF8QQa1FgFY0k8GPoKxs+yB+4X8qOGrjSWFTWsLwvns9OWLcSCas2qYzGw5r8
	 hDo70FWvbz9z60k9RB+dm8F3GEtjPD2WVHZM33a+DB0i042YNykMQ7lrCt+QoYEpP
	 eb60bZ1DHdMszdFe+77w47E0dkR5SjnP+ZXBhjLKJkRr4aDcirUz59ivfy8jQ9LuI
	 WghZRVt2MgpWgMAMdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myf3x-1sYcMc0AmL-015ng8; Fri, 21
 Jun 2024 16:43:43 +0200
Message-ID: <038fdd79-b465-4fa7-aac1-1526dcb2d87f@web.de>
Date: Fri, 21 Jun 2024 16:43:15 +0200
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
References: <0148e3317b0de3b5d1eaa58af37a2910783a69c9.1716552602.git.babu.moger@amd.com>
Subject: Re: [PATCH v4 17/19] x86/resctrl: Introduce the interface switch
 between ABMC and mbm_legacy
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0148e3317b0de3b5d1eaa58af37a2910783a69c9.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MNnmo/IyHwKqbRCyoIgDHyeZEjlR0nEzdzSPleYk0UD+8BXXGDY
 FmRjHDJxKGTwjoqH3iwFKGuTZrfyZBsZcAr5ziCVILX9XUi+zdzBnX1oODVzKdT0hEZgPM9
 0xVp9/736STKpYtKMLYtVHHoTc1i4n/z2mTmuAkojH39STMU+K/OvodrbHSGqPZQdUYj1/4
 zyiiUtH+Wuly79wMYzorg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OnHt1u3JZdQ=;gd070flUBWNk+k7P8Kx6U+zvKuC
 pvB1NsP2QsZTxqoncBTsd25maX2Mhqq5BVw0xSjduzbGp3vQSz7OAIzeT+uCrKY6cXFd3yk8E
 JGBAreD4BEVsoBhkdpuyDrlIH81+J+llZ2pWIKGy2PkijNFi9PHY/wTzvsnkB0Zl0E+ortN+8
 iuUBQkDaiil/YC6TqUYNvOQdC+Qt12eJ3wPPvdIFFbo8vG51COOVeXHz4Rp00716ZdZ0ropLC
 nKBpG3skMUlSb7of2/K2mQMmUNX2tBFfrzgl7Wtnzdj9pQa/L63sddmboqCDqltcNOBDcav6O
 slCL+uJ0DYHdatDvfTc5Acws1+ZudxlipIpwVA2dVS5vroGYAPJ46n2BOrh8VrxJjJlNI6GlS
 VZwZMgcy5KHKUTV5lT9X17IjhvQliIj+dYoGb2mypmxEsPiENL1riweTJSgrl/8JefDxPrZWR
 haGd9WwKx28iSERQ98kEXEkVMnV85wGRCELcX9/nnn3Jg016ztM+7U73D4DtXNW4KGlx//er2
 wXBy1g+3fS/hzT7m/l76LIui27AVd4KBFgFrRDLn/klU2KILZav34tv7y1yZXP+qkaxnogjbr
 FEuTZiX5PIgmM8O0cBWAzmJgLip+lrZNLzO+RXXOFi71NoHAI/s8+k/FZzFeteK8IJvJLLvE7
 pXv6bhLhKz2HDPdt3C5VF0i2CyMZE3233XRm9zCQtXp1nHKwKcxU75wikhSigQSYNTpX8lXBT
 XpIXg9JZHZEGGfbHFyvlR3NGPPdfuyr8zgCu1ze0Hf2fR914MQ0uvppbDxxqAYjB71N9nJhCm
 Q2BxUYYx1QxQSTj/YXeyYcBOv95jgRQSUPET3yI/Qtduo=

=E2=80=A6
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
=E2=80=A6
> +static ssize_t rdtgroup_mbm_assign_write(struct kernfs_open_file *of,
> +					 char *buf, size_t nbytes,
> +					 loff_t off)
> +{
=E2=80=A6
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
=E2=80=A6
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
=E2=80=A6

Would you become interested to apply statements like the following?

* guard(cpus_read_lock)();
  https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup.=
h#L133

* guard(mutex)(&rdtgroup_mutex);
  https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/mutex.h#=
L196

Regards,
Markus

