Return-Path: <linux-kernel+bounces-560176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A40A5FEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A867B1895C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F981EEA2C;
	Thu, 13 Mar 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="OWlPSUU+"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23551E51EE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889592; cv=none; b=o7eTGj92lUNDXQimidzVSMRKsZE0eb0oylTUdGayqhQ+/CeRDpSapfHw6PRLXyoDvIVCaHhGNUPGxfNJBroclis4HJRvzaBOTRu04gDQ+Bl6xBxiaPPlrbfE9yhyk9iaPBBz6utPacf3xdjfSQz5FeF82juyAbDGyM9Hpp/S6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889592; c=relaxed/simple;
	bh=1AoFDqhvACB2HzeNTNT0u+anlzYiEjXZpm9yzqhk8l0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=btD5OfbDHYHFvPj8uMTe7ESrBla0TW+wyagyTVpPye4NLh8/Nxb8sbhHJEX2qOPH/lpZZMGZnF6jAd1aTjIkBibTxF9fUlZWKKeWa6cxTAMPsuim7TnT88u69V1852wQlkVBX2cg3LsJhhCK3Nn+fNuO+W/nuN0hvR4rwcIWjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=OWlPSUU+; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741889575; x=1742494375; i=spasswolf@web.de;
	bh=1AoFDqhvACB2HzeNTNT0u+anlzYiEjXZpm9yzqhk8l0=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OWlPSUU+4b/cD39APS7gvwuhldXLEfXmg8g1YQ4KOmtAkptchCePquUhnLFbMQaF
	 NI0DTPhSS9QwuKY1gM8xudVOLnorBOz1qvgWBHal4wZBwSLCwmtrkxDqK2DFwxDT3
	 p6HeNvpPPnb+k3PslkbVL/FqqA1Uv5lHY0oQCF0YqQVR0O/Q0glGPwpPmh9AgZPeR
	 NJ2b/5rlopbPwg8Xj51wFouO6kadeJZLRVBM3vCErSw7DZTrl31kcOsc+J0nfsyOa
	 QY/M0awT5Rbg/0Ldf0EmKFmXdicssB/Yo8X//py8Des59sepIhm25J5mqrhz7lytE
	 z/6NHCcevKpxtQ/Zwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNOVK-1tYXRl34UU-00M0Yu; Thu, 13
 Mar 2025 19:12:55 +0100
Message-ID: <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	spasswolf@web.de
Date: Thu, 13 Mar 2025 19:12:54 +0100
In-Reply-To: <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
References: <20250310112206.4168-1-spasswolf@web.de>
	 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
	 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
	 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
	 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
	 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
	 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
	 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
	 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
	 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
	 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
	 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OC9XEiMv5QEuE3OLvSzNWUgrnFxzsuNZkLDnjj25iIHUrEmwjPx
 FYoK+VdqiBsx/2Omk4Rw7Hc5eIqHQdS4BI6H+v3h4Ye1NjzlhyCusdvWxK+/7d/cVyFuqSo
 c+OF/5Xhuyvh6Wuw6syEe6MA7fhZtufLhNeSs6bo6rddpTdi0v+iZ0QQiRRHU7Q2PICQjbl
 tHseoylqzGhhLz2i35JbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fkCnkONTWUE=;WR6SZE/b7CKI/qD84Y3KO3mRhVz
 8G76d0TZ8IeBjLh/Yz2eamzfEDylIzOyGxv5P+mOpDRhJc4s7jfeMj92nEf28PlrgYwt5qE7c
 EblmdCBjl+34YTzhIgt7sIhWXDNX1JU4LDeQBsgDhj6c8n6UZgIySbiKmgydHVLGrjbFaPqr5
 dPiQcV7F8vWiPurzLsqpA/4FK9eU8TPRoFIs0k8XbCELK0cRj3qfQiyKncBMT7b3+t7CyJ5cX
 RcEJoKf0kjhM2qqWQvy6ayz7DmGUGtZPFLgPtdsNV/Z9BhN2wqzNW7rjJ5jgPPIdTFM2E7sdG
 5U2Cs5wq6p2kNt1etQf1Y5cI3NAs9TszT0JI5bLWwuKLg1CTcLFUTy5Mv20oToygINY6iu925
 PY45Uy5CW4fIoYCcgHEUwnkOgtowPdiRNznZkD0qMm2zge1iRlfJrMIu/BW2vV3s0B2KVRPsL
 BuXh3V6PI0L0rF/BDqzgtwU3eXJNOCpBffmWmroqNkJIyMDfcMyI9woeogN3nQOVRViQ1A7j2
 UN9i39iWKBzl14p2WzkYJx3OUk7AkuM9nvHH3lHe8ep+WU+OsFMEFe4UnQyn+MtDtE3qrDaNS
 9qvngnOOyQMjHDu6ThFPE9vJO22p6NUBhC402614v/WYbXUZcSgz7zpHoD2eXaqQVX82HSEqN
 fBBS0lYrL3bFbHWqn1KdklvsBBN0qTSfExj3iPH96l6BtZTN9DaxkUtGX9RU6ABn/gJPIUL4X
 +1/wFfbiWs3AH+lx0W5QXudAWqwSVH0mEZUHToOV6lv+tPeFAaihqcFYyoHiJr1uGnrIjxq1Y
 IFJpaorZmmRq4ef525nJQqFa0Be5pKBpwifBSXlTKZtLWLz78iXqZKLHXsdfx2Jh0GMGP56eJ
 KYgnmmvlnoHciSGXmZLuEYTGj4HdnHTzl3dhHPLBaH08BlkY7lL9i79ksq5jedKk0BzXMdpAN
 YIoHbo7ms9Ap6YHb2epRzXd2tqaohlfdOcYoB2YBhGwlemWBiUFPn1t2EDztl61DP6SK+G6lA
 W38AKUz4JFrBt7sx5JzT/FvwMyGe3JeE96LjwBlbeNFs8zifM5t2k65eyex0PfGPBJ2J6xUv6
 Xl9/gxptV1eocjB380Y7vPpSktSgM+TweU8jy+4zdbdComxPoBUD3ln4VgoJkKPrNaIJ9m0lb
 AOHWANQT2DYzq3bQN167HlTtzOJYCxYn2dkkxp2QSehsbHvIPGLptVTrlfvAf8iLGXCadFE4v
 17NE+EO04ttlKW47m8TQjVtyt/a6dWPOCJjPzG6V6F90ke5vBcd3pEBZbOTUkCD1rw8+b0lO+
 zfa3QH//rUFDmKxHjGFUwut6REZe02hgGbyEqIq930Da/JPbk80HEMGvDH0zDQ3mJ786MkZrz
 +e0JRh5RLc5Lqmg8XU5LISpyzmgOOCCYqAhLK33pRlekIgKNz5V2kfgkyx7qibaopIAJUUl0Y
 K17RP8A==

Am Donnerstag, dem 13.03.2025 um 22:47 +1100 schrieb Balbir Singh:
>
>
> Anyway, I think the nokaslr result is interesting, it seems like with no=
kaslr
> even the older kernels have problems with the game
>
> Could you confirm if with nokaslr
>
Now I've tested kernel 6.8.12 with nokaslr

> 1. Only one single game stellaris is not working?
> 2. The entire laptop does not work?
> 3. Laptop works and other games work? Just one game is not working as
expected?

> Balbir Singh

Stellaris is showing the input lag and the entire graphical user interface=
 shows
the same input lag as long as stellaris is running.
Civilization 6 shows the same input lag as stellaris, probably even worse.
Magic the Gathering: Arena (with wine) works normally.
Valheim also works normally.
Crusader Kings 2 works normally
Rogue Heroes: Ruins of Tasos (a Zelda lookalike) works normally.
Baldur's Gate I & II and Icewind Dale work normally.

Also the input lag is only in the GUI, if I switch to a text console (ctrl=
 + alt
+ Fn), input works normally even while the affected games are running.

Games aside everything else (e.g. compiling kernels) seems to work with no=
kaslr.

Bert Karwatzki

