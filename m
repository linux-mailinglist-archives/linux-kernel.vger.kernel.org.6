Return-Path: <linux-kernel+bounces-426194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D712A9DF01A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 12:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970E9282B2A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5774616DEAA;
	Sat, 30 Nov 2024 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="un4w9fyQ"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49013C695;
	Sat, 30 Nov 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732965816; cv=none; b=i4P2LnPoH9Dru654P1ufyefPLf+Zepsz9d0a7DYVx+9FCiAlx3JMftHbXO4+PQnSlA3/yeScke0gzuY8PVMxfEFCfPtQ48gvtpHZo4cB+ZmhXe9SAIwtrNgcTmyqeQRcVJ9u5ePFF8vs7a9n5+EByuy2dDojy7qlIOrCB6e28r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732965816; c=relaxed/simple;
	bh=knzIZJGI/ka2HQESpgpY1s9ew3sLGgzZogYqUV0m55E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tJ661O3aooVJEmJf5uMMnQFrh+RgeOn1J5sdkh/BQLqPgP9IwvtRBWY2nIOn6NkS4SpG4bxLfnRPA7QgUq9XBW203w73/HaUMigHVRmS8cuQEbDGvYQpHMroCBBE9g9FUHJU0ubSnnc2u3A0bZyT3AIi8Dnu2V70Br51+1BIYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=un4w9fyQ; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732965788; x=1733570588; i=markus.elfring@web.de;
	bh=knzIZJGI/ka2HQESpgpY1s9ew3sLGgzZogYqUV0m55E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=un4w9fyQn707HCAS+/OpHumpmCjQAjgXooZg4+3sHRB5DqhD/8aekJ0cDG6llmht
	 SzAnEBnGkARWe9GK42UyVMWNjfZ5dHD8j3AGeJXBQUae1xggkV8AY5V5wBikz3uzc
	 LhfVho7uJ+SEd3Y/PjbHB+kDTgiLHYm9L1qwmSlxPsWjrGeVVoEkcEti56MZ0EVi7
	 zlLe13s4fXw/9HBtHBieDWnWEaakNmQACD0GvuhOgAMP4S6dn6U2YfOQp8pL/IL+h
	 6Lru/wLU7G+dWJZPjslQY6Cny44r3IW29j7N9HW3rJG4SprFE2I2qh+rb7Hv7SZo6
	 jxl+i1XurwMMuF/qLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1aHx-1tEsit1LFT-002xZ4; Sat, 30
 Nov 2024 12:23:08 +0100
Message-ID: <55392b68-1159-4b95-b107-6aa050f45c11@web.de>
Date: Sat, 30 Nov 2024 12:23:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>, linux-sound@vger.kernel.org,
 sound-open-firmware@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Takashi Iwai <tiwai@suse.com>
References: <67d185cf-d139-4f8c-970a-dbf0542246a8@stanley.mountain>
Subject: Re: [PATCH] ASoC: SOF: ipc3-topology: fix resource leaks in
 sof_ipc3_widget_setup_comp_dai()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <67d185cf-d139-4f8c-970a-dbf0542246a8@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9oJrICSvB3vXxBaiRmuxR0PPz98NoJQ2znt/ji/AqoCtWaw+xqd
 TgkFCMkbf1h79bPaRjrPgBqoRTybbWTJarYHtD1Brf+u3RvaXJ8Nr7F/BuFJkoZU1uR69pk
 /SDJb/cjUzSFJLQpJqYzBSnWueuw6MKviWoxIFDRF7MC7+t3MsQiJBEQx2QO4RhE8HaJ2r0
 8JV+1Ge1qamLsY7Y9aimw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vTjTXEZz9Vk=;T6qK9UwbxJYOp7SjCirLjKhpnSA
 rgqJ10PUWDlYpMKXmsQ/Q5vDDU9KF0H5u7T+6dymutBrfxXq7E6oqqC6qxYCD1hFG/fa1Fh1J
 WRTxtplrmnTFul7f3Ip3/PrVlkP4ko92+QO+FumuwByxSCqSaJdwE9Q5i4IcRrDsgt6RXkl0w
 4c3dY9GTTotKstjBDbc5sruyIOson93TCAjABVaY74eYCTFRMCZPVn7M3qjyZNUZXqg+ttOFI
 eHv1h9yW31hvcu3Uq8u+rX0gakiCRkXl2zE7NgWwEISos3/9cFdIXUZVwFXRNjK7zbJhHpJGO
 d18juXO/IMKcNoPzpcxjjWK08K/dgHww2eZf4BxOwUigyH8H2g0IW+tux3wnHre7Meyy3ZwTE
 ecJcL+Ekbq7QPPLpNCNUrX4CbV8HGHat0TaORTYqmZGtlcLL4IA1YjqT/gE6PEqrYBd7p57WT
 niA+Pifgazh/UFKKG0Bo4Ri6h2WgUYW66IdMQ5rO1792Ew+3SIgn3nbP4w0OUe5PsDsV+tP5B
 /Uwl4hCJ2TAqPVT/dkDzOY17f0GIXHdSnTlywNZgkORRRSoidciDdRgSd1BGtctYCFmt7tlet
 y/H8KPa0DCa7Hb0xaHMG+titvot+Y8jneL+8yJuEmKsIo59dQOKlEWwp5Yk5XlSwFukmcys9e
 Kezdxdo5x/1uHjsAhgm3tu53Ny9JiwWkhedIQvfz0dD68+FY1NFS3AspBvbUUGPXMOO9pr6sk
 ZGAHsMVSey8PF0rXcVCJyU5nniPHe9HuLmRb0mU6Prcy14Ito98VBThgzPR8qgEdb3LAsJG1x
 N1owPRMpZgw8wd4Rkv87IdDT8geoiwa/AV3ARhV9SSH0Z6I4OBOCyU1lmmPiDuST1wur/oSOp
 Ny+OVywvyEnu15OctpzhfayiVJinEufDZ8VKAG6gfhnetYsBhN3zCCCe8duoSJu6uGbhEmuQ1
 rOYdoHHbAzOrgEFphCzCwPJwzzlkyFFWqiU7W4B40Ru9ZuCd7EwRr+b5N0jIlE+xLY1IafKl4
 x72qXYVWI3Xp/T3SGWZmuD59JtuW24oRsS4XuU1EK/rlAKFIOHM2m2yU7xBuBAZjlDFkQniGz
 olh1nv7Lw=

> These error paths should free comp_dai before returning.

I hope that such a change description can become better.

Regards,
Markus

