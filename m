Return-Path: <linux-kernel+bounces-424944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884CB9DBB97
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE97283E87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469E1C07C2;
	Thu, 28 Nov 2024 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Izvg1KKW"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EB1917F1;
	Thu, 28 Nov 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812945; cv=none; b=mhpZ6Fi6wgA9RHpxstkYR8qtSKsW1eOzdOgIc4RHc/i3W3kyG2MqB8GZR797lhKXlSieqvsk5N4lRXPdb2TZIMNA8AmnqoROli16+uIqtGypNipZBSERQvkgp/AJeBwcbkYwY2FfoTda9ylQdwC/JivCMeNMk4Plt+azB18nWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812945; c=relaxed/simple;
	bh=W3y6o2f5xz9rNqZ9887Q35QsJkDOBgB7JZg/H+7Xppg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=OBKG8rbbd82wBxmHWVygEPnuROFeKmCy+rVEixyHne7Vv43eu74uotMQ/qfsQUfSi56Wo4+WRQOv1UiDq/K89RB9kBLcMpDMcL6BNn1bnCNvW396ijLg0WUTyYloNpHFjuOdEh5xud2pFDmnJItwmsrCpByHZXLo3GA1NCMzdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Izvg1KKW; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732812915; x=1733417715; i=markus.elfring@web.de;
	bh=W3y6o2f5xz9rNqZ9887Q35QsJkDOBgB7JZg/H+7Xppg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Izvg1KKWUB3ltDfG4oFw6ylKdyQyOrpJjosHovAvkrU2gCs4TVpE8Arscu4uq+Jk
	 aDQN8teNRynVVDfNOnNKo7lj3wUextPwk85J2bhuQjhzLv7BtTjk1qUG7q7MpaqCB
	 Aos68e4Uq6bTlS19xYy73o76mmwRMcJVvRup98ZcR2viZucHGgDyHkVLgNc0KBp19
	 xkZ3HQP+ADOoh5F1JxDupMSRmL3S4FLUwsl9ZqbAeXOrcSCgTKHXwJlJNtLvzbxXD
	 un8l7uwHjz9TnV5PVqavvE4jIRitxlRHkHGAC5oln0ia//VXP3OQx2P6F3S7Ik9D/
	 86cMDKbNUfovvXTtAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhnu-1u0BgT33e2-00osl7; Thu, 28
 Nov 2024 17:55:15 +0100
Message-ID: <24c67074-c211-4ec2-90f1-d1f3eeee1005@web.de>
Date: Thu, 28 Nov 2024 17:55:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wang Jianjian <wangjianjian3@huawei.com>,
 Ogawa Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Wang Jianjian <wangjianjian0@foxmail.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20241128031234.3668274-1-wangjianjian3@huawei.com>
Subject: Re: [PATCH] fat: use nls_tolower simplify code
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241128031234.3668274-1-wangjianjian3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6ljC1FnjOCfW7Yal19WkBEjkuItDUE3LgvzZ/LsPu1P9BYW/T17
 OmW+3qSW+J+WTMtKZt8A3xWIjopDUeU2dNC14j+2ffutpQxFlzTUq7aIp7Kwwvcpgoue6+5
 N650cdURicnaosZA/d8CmnWj/sLkNYhePajET8gIxvNPhOkmoMGuhWiz08TSTGCLKUH00uf
 +OQbj1LiB+hn4Ruzhy5wQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tVvp+OTyCjI=;CDV1Omnwl9toa0Z9IhuW5O+pGFP
 OsXXVJ2CcPgknK4rNq8b13LBHD22VzqtacFJv64vEAv9fcIYT0u5+6BV98Om4k01jeMdIU306
 wbOZPr3N7xRNcEMgF63jZpWg4pZbz9Lq6oXjs9QY0pVfoUfM1qjMtpGZ/ybAIkenHWSh9t35P
 /ppX2BRCXKmhHRcGoVlzLzm7yfz4bDgpfepqQgbbytws2KGQ3nvlBBfelGmtJeBQDI7iRwMtj
 ug871E8csHhOWJm2L8jXWWR47VkE/ABqZPnPqnaSlN27YfXGI0E4autd2cOI+qkhzsv/1aveq
 llzSQrf/qg3e4AUed5ESs++PKjCgXzoAeBJgpKu8notQ/MPUQhC2A8vYtZRU+cSHb+oBoYZVq
 wFhRJxGfhPIKRiWnOKAfsMrHIvX/0l++3Tk2RSyqg+LS7lfF7Pr8I5cBC2cwXtq5YeXk42jdf
 y7p9XODcNHHBS3jzmF27IEQ7k21Rqet7nT41y10kfSOyD36Qdh2PkeQfInnRRVYyLUNtEdSiC
 C6vbleam0AnxB4sD+psb0TfF/yfVa3Cur5KOERAi+nZFeLfKe4eCJRWJXKG9lnTra5WpyDqCF
 iM4vuDXLToiWmBp8Nwo6TfghGpAcnHjJF7zb9EBQRXAx3lRig8jDbFfVgGsFNnUfe0fOYck4+
 fv6ha7lGPMFn77isn6DrKJ2avAJpuV4OrC0VURFovhEs8BJDPZja+CscEnN3c39lWX1TkUWNw
 AfGmk4ckM3kM6U28l3VX3Mpkl5YX6vOaBhP3cGjA7H3qYK8T6cbp9jaaTsw5nD5v6c0JmxqTq
 hq5AbMX0Xa3P9W5+nEErCntjcqxEwYViMtVu5kLKJnxThfd8Sot6u6rF2bTvFdLSdOLouZzZm
 y1f0ParKtbdSINNFwQTr9djDuIw6Pjrjql9CC3BWprTDMr5CZShfwTUkl9pEwnomRVjxF8Jtb
 yM3oQdQaw4Op/i3LQ3pekVhIsh9lfHAk4qQXEMPlxCvoBSRM5/gSZwa3bHvBaFTstYhO9RE9q
 3yHy9jIAzHJoUFpnjddVGN7n+xF8wcpFhdPWnl2ecdFn1xtYPXaMCR9qe2KCCT2YajtWANXk+
 SF9Agq3kA=

Will another change description be helpful?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12#n45

Regards,
Markus

