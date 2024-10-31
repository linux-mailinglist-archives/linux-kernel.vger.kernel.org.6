Return-Path: <linux-kernel+bounces-390842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A9C9B7F03
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785721F224EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D0B1BC069;
	Thu, 31 Oct 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hHSxl4eB"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D51BC070
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389728; cv=none; b=oVexoKzFwJpvoJUy8b66kGrpjhI99alHEXcd/nmtQMDJRYRgZVcSemJEZ0GU9wHb4VnQwjoF4efV+G7Hm6HHnXjsmwH1XxqZvRQLnubIu1+v7e0JxYMt7wjbt3DucMPs2eJWUSNf9nhmOjUSx61bH0JJGBm03ZzZeDb8gw/P5Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389728; c=relaxed/simple;
	bh=GUkc+8RtKgct7Ds7007ROrUDlEaBE1pheQ4JLEh1vQc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tzy7UTgeNyRPmb686w7kw/QN8c4MIyBgRGBPJZ5JZdW9UmyU5XjsiVGHL63Lk2YrnaPLQu1iVZCfMyU/GO7+bElhGf/nG8m9Mo4PioZOXtWpWMndbFlED7zEaTxDrU5S9HHMmIxp+c9sAGe0AfhIdo9OpO97oHnknqinL7I8/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hHSxl4eB; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730389711; x=1730994511; i=markus.elfring@web.de;
	bh=GUkc+8RtKgct7Ds7007ROrUDlEaBE1pheQ4JLEh1vQc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hHSxl4eBGwxPkinGGhMBcvDfO3gmITWzyeW+Rnb0BhMWV7cNEpV3RxfeU4+QBnEF
	 qEJJsXu8OBfEC0zPbm9X7Nc0Os9ypCC5X3hEd0F++ujKDy2TY5ptbH4zrfd3Jw8YR
	 lmK3Ll78hghm20H6Gs9nVNsKdKDYDly5bsKNvY/ivzmGfG9QUfBqOcuDepe58q7fv
	 60dDsvF+27IBGfPvGzt9ddLemm+0XFeGQG7RRM3eKNa2bl3CbPCNXhPv8qRTEM6Xm
	 3GD3zBTdaK0Plj67J0pbyZ4EnvfJfiMOVHvSTOHVtQLmAY7VrVL2hUWtR4RLPQYme
	 jJh2ASgVK/8VdgX/Sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALeR-1sz5Qi0eAV-005zOr; Thu, 31
 Oct 2024 16:48:31 +0100
Message-ID: <7d4df724-5b83-4e0f-8fa1-c1eaa77827c2@web.de>
Date: Thu, 31 Oct 2024 16:48:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Antonio Quartulli <antonio@mandelbit.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241031152848.4716-1-antonio@mandelbit.com>
Subject: Re: [PATCH v2] amdgpu: prevent NULL pointer dereference if ATIF is
 not supported
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241031152848.4716-1-antonio@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oFvdSBs0i2J2tNH0lC2KClHbAr9sjTfhbq8SdyVrZ51wHeM6wuu
 Gnb5U5Cp4CrLPuIhy64Wdor4jWXM5wM8dgm+aupVdBgfoGNyIRDQy6s4Pa/v5FOb4rXYg+n
 bxHHisnM6wdMzXi9lIHFzP7r2LpzacKS+r2FbYRgl8En/GmyOD1ZsqX2/4+IXYjX+nFcV8b
 gw/X9uL9KJHcQSg3qs+Rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3zpQau4nCug=;KYT02Py5jdhE7pWn7ip55fHqLMc
 4TLIQCYYfm0ZFqvSNVlQG5dvTd61jT7ly/I2WFM4hzKHZ8+x4cej9k1dLYHa65vScx7+IKeEP
 JyQcTC/ojQCXzEy+SKIeVq4S0VxRQLfxRR2dZAGeg/HJ/Djmj+2ZOWBCu2MaRehhKiTX8XUUF
 aJqREMeNCnz6bzqlpwYOdT8YIyPdb9OF56hcONymSY4bvF4SIwSORoTWc9srPKzoMNvTOe9SA
 MF11gSDO+awVwQwDyVYrD/viRSF/8lFYofmVl6ML03CVvjbxg93cDXcRyQhcYZRWXhlM33T1h
 1SPs1MRzn+DlkUBNvO7rON/dtSzQPNWQIotdx8mmbYF3CIX6UVRrsVYtJ+kUCzzI+R4YKYuxR
 Nh4uSk9g2Kwib+Ni9uVaKY+1luy9u+ff56ThBvcMrzIAe5na7T8o+tgOvv6po4WNrGM7UTWG4
 TO/cEYN+Avm8Q4PfzUSP8/6bxQufn3XBB6ZITdMrmhHCgW8aGiGnRm6O45tzP/axitIol0tk6
 zasoZPmiovRz5GOsdvsWF2BDUcMwoJAzvtqecwkJ32t+gvZmUdznfFaHagVHHiTv33HFx9iqq
 NdhLvWu5ekLQ7Wn9qD71qv6Kp1BJ3vVxF9/B6cNQgCZhqOgKUtwpF/NP2MezHW0khNdjowqTF
 TSo/luESv0afm4v/O7+lbZBEEMEOZlJa45m+W2xQk/IbqJMCZZhLQgNI/b4oRBuTEaE1iGQ8b
 eTGcc6EC9tB+GaY3Um7fMvP8V0tAjUoVQtEEfTjjzvL2umFD9cKsJ/+kjDhMyZQy9cWSy3KKA
 +RoSU61OvQZDgL4pX+fkY1dg==

=E2=80=A6
> Although this case may be unrealistic for the current code, it is
> still better to protect against possible bugs.
>
> Bail out also when status is AE_NOT_FOUND.
=E2=80=A6

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n145


Regards,
Markus

