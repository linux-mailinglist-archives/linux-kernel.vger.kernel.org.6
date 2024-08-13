Return-Path: <linux-kernel+bounces-284295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0A794FF75
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909EC1C22532
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766CE13B284;
	Tue, 13 Aug 2024 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KbZ95oi5"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000613A888;
	Tue, 13 Aug 2024 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536959; cv=none; b=mlwtcTL//wpP+sMYoTsM3uDL6c7ZsWEte2OpJvCvYD5qBUS8eDsnBUNgqHsLICkefxHQuRAuhdJEfoxNrgOM7G7D4q6o5Zc+P5cZaSSMavdL7K6YZPsgYXpR70dJZr3mvr0ImueFHOnWwS7oYB9dDSEWx1bQPZQhHW2IuF2AkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536959; c=relaxed/simple;
	bh=/zxWuCigAOZMa0LHvT4UlSCvmrge5aJPUb3FQT6fhjM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=goqOc9Kb9NBTYE0oYR1hzw31JKJ9+2tj36kOng3HQXU02nbz91ML35S/bdZuYZpAdtORaWi47EJkOz7i77iNZ5HvYewvS0XoEz6Wyd6Pw1BfM7UUL3KyjkBJt/im+vM4lI4rZXkPW5q6f3LZfeyP2/LKzrOpHyw7VW8MjxPJOlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KbZ95oi5; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723536931; x=1724141731; i=markus.elfring@web.de;
	bh=/zxWuCigAOZMa0LHvT4UlSCvmrge5aJPUb3FQT6fhjM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KbZ95oi5zQG+BEt4Al/BIyrjDyS+mW3MIxWhrd53KhucphEn2quFAQbJ71B+gNck
	 GeKPGFJnADM2r+J+RUnHAyl5kee0kCVwR+tG1Tiu3CadE9BU+g0O9lu5rv7g5RBqY
	 Mrz7l4zUtq8QDF23Y0G3C2tgMLXytq6uV/6wDQUoAtDFHg+GAGV4rhTARncdQMcwq
	 PGlflzhlzmtkXdU7cUzCo7Y5aJfimIG8iTwm4aNgbVipeaQ51Pb5HIHS60fkPi9+l
	 MYy7pVLCgdEEI90yZy9/AxVKdZ3tHfTNpO/RRvNmThu9Re40H3CZSSw2spZYjs9pQ
	 rLxrNECMiPrXHqMO/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl4x-1rqAn80BMz-00kGT3; Tue, 13
 Aug 2024 10:15:31 +0200
Message-ID: <f76c7f8e-f4e7-4ac6-87e1-1ba9b2b19a82@web.de>
Date: Tue, 13 Aug 2024 10:15:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Basavaraj Hiregoudar <Basavaraj.Hiregoudar@amd.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
References: <20240812110514.2683056-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: amd: move iram-dram fence register
 programming sequence
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240812110514.2683056-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lUao99FJ79AR1pxh0fzixQ8WA+l8YYMafn5UJK5SH+jP6dAO6Qo
 Lhx0M9Fe9VdZyoi9l65alY5QDWT5IR8CdQDXvHiLXRW91QUW016V0T4QVzt/Avku+YjQTWE
 VEjCs/dBu86eyHCg0M5DFcqKSPCAIe8QMeajhSF9zycA5LmgzQLPXkuo5bBKnHccQh79sDR
 C0LwzlQLcY0O8CILuixew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E2WEPVwt3I4=;/6gahyzGle8erfIcztp3D5k2zK1
 lh+tV01IULZDinl3X2IgKB9KyknTBgWOPuCtLNKLwGbOp0M0JVLGagqkxnmiyrG/PzyuHfXHZ
 4CwngsX28EXBQflnh4IxOIcO8eh6OsQEWyiu2KzQWxXjIfEI3CeE0f9PCm2Bbvq6ruFU1YDmz
 3Of6acoPouIvdctXDLfjpz0IvEBaVHkTXdRakjFxtte0pJkr2EGYBuHd0tj20QOkPKaigdbqO
 4cltT3krRrx5dqsPE2x1ZHFJ3q6jYB3qFfl5OlMlr2QsBcxv9Sk1SrKLUgWy4iZ6bYkDwKULJ
 RAkgGg3FL0KFPs6WQB1MetG6S0VQnfz2CS5qEvf26/3339JBSDJpNydolKsuYeNKQPInXykWY
 qEphtrjadSwXKzTjhAieJfPvGfjP81TX7HmQg8ToP4rdeNB6WNCf+BTnTbjAU31zL1vEEjpIB
 mOEMed0JHMeC24LwkKC2B7tKSt7Wrqu3GMhsTUe2RbeKUTUWhYQoWWaPsyYe41FcYHa4hf4dN
 gKdP+tpjfimEam5RLR1WUyITEJpy2IzKIjGZm4YX+JzNm/cJPWxBeio8cBDa3PDO6s8zl/cMn
 CtsLOt1hP37hNKIL96oL8Q6GjChkprgL4Vps4HxeU5omWOBhYYgnde+zUk3p2NU0CXOYR5/BO
 FEREBC9Ol9DO2naPg0vuhkzvM7/FBZFXyfhB2YKliUcvkcAVSa5Ht0T/i2jaIb1Myoq1AGP9A
 46WSOtRRIeS/5kjIlhY6ILy3V019iGHhHQeBpCS5ASPjkdVoedILkqvGd0JiEEWGgJ/60EAkf
 7/zKGbqIkT4L6/DXC9KmJ1wg==

=E2=80=A6
> before triggering SHA dma. This ensures that IRAM size will programmed
> correctly before initiaing SHA dma.

Please improve such a change description with an imperative wording.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.11-rc2#n94

Please avoid typos accordingly.

Regards,
Markus

