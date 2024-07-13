Return-Path: <linux-kernel+bounces-251381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A2393043D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4EA283F50
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 07:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F72428689;
	Sat, 13 Jul 2024 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Zt4UDs4L"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1FA1BC3F;
	Sat, 13 Jul 2024 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720855027; cv=none; b=SbLE3SlGqY7aHO9sO/RHyoOUz6CxkoLueFBldLvaYRmo+DdIWwgSjk2m+AOp3/Gv7aqtZ7B5B1C7d85uWyuhgONuCmWpZmM4U4pAx7XcC3S4Pm+jBqzlAjb0sg/1Hv7ijVnJ9opqnORVjmLQqqjlMj4GKGocRNx/EGlIJEM0RF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720855027; c=relaxed/simple;
	bh=shyD0e0NYVMkydaTgXlDzFg6ynFBBFkSK2k1pJF+MeU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fK52++7/YCAJs1SgrxIFZp4regBBaT73ii2CUSST8jvipSUEw9ic2ia+X6sZeuUOEl1h1i9RI8RqlyzZ3m+QQdb4nqmeTt+tMevS2T2ufk5yN2xke61ENE6FdMm5Z7n6wOlsyAAkNozeUpHhquFGlh8GuaU1kMpdT2qW0lHrV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Zt4UDs4L; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720854935; x=1721459735; i=markus.elfring@web.de;
	bh=lGT0IGqj2Gekx2many9OW4kUSA4BtqO3fHSBiEHG7Co=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zt4UDs4LDu79Ah5JLNzCDgnKk7z/+vmUQXvR071IRYhGZHmv6y5gwoYhmxunOF1O
	 zh3xPPsUtsKEY5s7dGer6h7/UonJ2zO0odpPnIeUcr52QE3qjSg9TVw+HLHn/y4W4
	 XeRYlyhUtNIdAd8/C9PjnRnInfaCbJLveyPhu7Ax3BTHRtAEvBg0ztu+mF6DLhVn+
	 JkIoIXrCHbbLw4tsUO9B0FOmeBGnfi9V0ZooR3ZOYdoUkICxqBkv+XH1A2Dsg0YAu
	 6MU8JytAeCamW+dRDklDf8jG7/KXHLBq9GN/Gwo2XNMNXuT8DDgp+8vp/WbXiJYIZ
	 9nZ3i98F26GcKtMHNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mho0A-1rp5UN04AK-00hfT6; Sat, 13
 Jul 2024 09:15:35 +0200
Message-ID: <20128914-b270-4bda-a778-fed63594d04c@web.de>
Date: Sat, 13 Jul 2024 09:15:14 +0200
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
References: <cce527151843aaa1a6001c75a17ee46108821233.1720043311.git.babu.moger@amd.com>
Subject: Re: [PATCH v5 17/20] x86/resctrl: Introduce the interface switch
 between monitor modes
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cce527151843aaa1a6001c75a17ee46108821233.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vsSa49I+alWCwjjBRb4HSU9SeADlcRzgkQR9G0b8HtQScw8ruUW
 yIgXhZveFRKGppoF1fUI33fDlzpreQKy8OYkFLBpLPBwpYtFcQQV5ILiWGYzBciP/bdsIWz
 vs1nAUNE5/7dVlxwAoqX2SRunjrz2FuYIskXSwNd+T8z4i398jz3viD3ob+COvx5Zo3VFyg
 8nwZRbU37sU2gwO//WjYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4Glvimh4XDE=;/vyFPVQ7oI8a53UCQmZl8fDRNZm
 925StIsKb2edSkWnUyEALe/s8j4t655y5owxGRWoortSWccxiDTBPPBJQYOpEBqvFUWOcOBTh
 8SZYVyV07dRYb4dJd2ALOTgQjhs2Fd1oNZTUfiSj0PHKa5/zKcSeU8NzVQbBkD7ov3NYih8Iy
 LhyT2I9o1hCH7/oqoWkKeILYwnJ4QlBGt8/evO7R5ZI3fAHc+9KOKh21RzSvkQMWbBvvmVN4j
 53niiaZX/zMavsvdkSG9Hzw34mKrupshlASksjS1o4Lq+gN6bbQ7tDoKOyBEdJ9CQtcszpC4C
 JaL0ETTZPa7SUZgzjBX/nwTzPtzQiL8f99rTc0Xcha5IR+ml6FD0pArDmrLzmT8D9B3nZ7NgP
 Kkovw2WrSTce6x837tK/315x4mc6Oc++BUoDMbw2Hk3RXiACbKADJba0W71h7B047bh6nqZNi
 w7JGobiSut+V0lZXQONv6Xynfd+w42yy+S2tulPnMMlrB+XzyrW7XE9lDTpaqUToaLmyw0nIq
 yORGkJHcTKZ+eXMEdoqtxjqVzi6TRdoJ2qBKB+v/86TFw4H2aE54l0lQuPh91d8sqbb1LbvAq
 P2H28vtf21i/faPh+3NyBdfPzM4UpQAsBs+6jii2vdN80o5emEMenxvVBxVZdeWEKYjQYCgYC
 nQ2nP9SPiXQbndushjUTFuF04Vb5WO7A+1ZaJIlAnGZZupJDmbwGl8TEuSUwZO914XEA3MWEZ
 HpKQcOutvwWrfO7lGFJdZ+5zAeJiNEqwnrn+QE1COpGh+whIL4V+ZCNVHf4tWm+gRGwQ3AQPq
 S2mtPnCu4KbpxWo2QJPr0QNg==

=E2=80=A6
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -910,6 +910,40 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernf=
s_open_file *of,
>  	return 0;
>  }
>
> +static ssize_t rdtgroup_mbm_mode_write(struct kernfs_open_file *of,
> +				       char *buf, size_t nbytes,
> +				       loff_t off)
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
  https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/cleanup.=
h#L133

* guard(mutex)(&rdtgroup_mutex);
  https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/mutex.h#=
L196


Regards,
Markus

