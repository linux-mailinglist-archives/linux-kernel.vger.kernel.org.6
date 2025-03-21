Return-Path: <linux-kernel+bounces-571227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB3DA6BAA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CBA17A673
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9EB22576C;
	Fri, 21 Mar 2025 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="pEtiuKG4"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59571EDA18
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560015; cv=none; b=mm4sgpLT9JIGqvwUXNLdUgkPCZgIkkx8FNuycYC7BlnR8+Eq2Q1dfwb28e41/TDLlvmg7ajd6m70cx90e4vWamk3jKQQc5+sfEx0Dn2IICVaXurBB6l3ZapKkCa2JbwLKVVlGbNhHExSo6qGv70hVN0V99vrFG71WTr4qOinKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560015; c=relaxed/simple;
	bh=SXxZiaLdZ4z9M0+8Ey2jniDWP2HoTeuoM7dRvbgWR6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGt42kuqKqW1umEsW3e3lvAfh7Her9h15LQSsmJYv25JCKctq2ZkXMfO+wQsbA7UginLGD2/PLSW8xKJbgyG5MZ6k1R1qX+ct/nsXCbczPkSPdO3FM6Q7eCxM4lcRWPOY4mDHCSlSDy7FF4/5oDYIP3+6O3/ttDYYjxVKlZwNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=pEtiuKG4; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742559995; x=1743164795; i=spasswolf@web.de;
	bh=fAp/e/K+ER1n135Om5Ydb7iLewTMQJFGtGq8rdrLITE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pEtiuKG4oBkwcXKaE3Lld4AJlnmhfZ8m1UvrGFfMUBm4HZ+ncfZdDYdAiiAknq2M
	 mVnIEG8ND6ZVNXFc6Eh5/x4ZoBzrq63emwRIoKjLqcOX/3jMjWUAOyfaJU4GErOe+
	 sPgEJCP74EfDHh47zqb5ZhPzs1bIxp33VpBUJjdkFych3T5k3zEy7vxj/oZRpDdh/
	 9jOL36Zza5+1GQMUN5dhl9rhvBBXMRmyXs2oAH97gOnkEWTl7DblepyGFCDikM46H
	 nKREA8BNGHYM47sQyLvf00Np/zTYOpVKx/QLZzz7n88lJSfDa9KwH0AqhSz1yyndP
	 kvVlL7dXgArXX0I5dQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjMM-1u18I31Qia-00COo2; Fri, 21
 Mar 2025 13:26:35 +0100
Message-ID: <d2158680b8962c248c9faada97f2a93b3fef1842.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, spasswolf@web.de
Date: Fri, 21 Mar 2025 13:26:34 +0100
In-Reply-To: <d3580fa0-df0c-49ce-aa4e-e8c945172939@nvidia.com>
References: <20250310112206.4168-1-spasswolf@web.de>
	 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
	 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
	 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
	 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
	 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
	 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
	 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
	 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
	 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
	 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
	 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
	 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
	 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
	 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
	 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
	 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
	 <841287f296579671dcd91329a49feed97186bcd3.camel@web.de>
	 <d3580fa0-df0c-49ce-aa4e-e8c945172939@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rStlZ0oxjiGkfbMMJdYE/uraBquVWPUt0cKrqqlTn8QRr19bqGc
 cmOqcHqWbWe0RSo5Y7NNxksBjAanVk2arPftzX0P0rFkJJMiHLa56pIKlrPID6euiG0hEtR
 VWSY+fXTFY7VEO0SVsw9sbhvb1c3tD53MSseHwz3RrEOQ3I0NTS/EEG2QKDIFw//uZ4HjHp
 +1r/DQeoCjBTbvvBTQljQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/q2118qoiTc=;iEBKZor2YOZNUwg4de6GhgDNK2v
 AjmuSe7AmZhEZtFq9IpAPrB01sNYr/YTlxo9bPaqEhx8NMDHZXGEvkRipA32EMQ+tXQQ9ogsN
 ujyvHTKMmD8RCTaR4VepAA3lTStGJX/S9FEN1H2s5kjR6AwST6KHP2pAKuf68jYx4KuJIzNqp
 /kWdKfBXqopGJVwEc7L+ZMFoc1njVyV+j4mRAPniP6oPojtuWTybCaNGQAZyR6KOpYQDKWiJJ
 C68lIRhvhsk8Kjy5QSB5XrGs1c+A32QERIRQhDQRHt6x/7EVrok35rowbvh0kJ2f7bqB4c7SJ
 Hvplv28putYXiRE6C6go6n1pbr5FnviHC4Z5xuVoJ3BwIajVRxDASmgJ9IBzedkAJKQKsso4T
 jkGDX16uBSMerLeHniFGQndbQvGIrkC2R2JAsrNfMZeew8QcSuLal427ZGmPU9zHRzdHYhwuQ
 zzqYuk7ugvJmtF7t6oMX6D/TdVaU+KcaCf3KykVFV4CXJ9XM5LueCBT0Xeb/d/thbU4tMIXb6
 2qI1SKtK058ndA7FqQ+8Cy2F8tWVVVtLmCbq/m95DY48CIeGfxSfD9Iwz75GZjYSZS4EjW3HP
 SadUG4O1JX+b/8CPoYDMkZdguhegF/5WTOY2qEiIEizXwsrTlHdmpptQILyrapZQmck3/rysJ
 g2/3NwQJmhQ23b2a2qQqSFaoFyVb6XAOA6zT72FnVAOGMRmrwKqKyxQ6rRzHmm+VXF1L9eMPU
 uTZqBMncxui4nJW/IOWx75hYmxWBALWNOVqIHo+9oInmRVIWFkhBwlLHSdtFGYHxSX3m7rwG2
 Pfki2P0PM0Bm66Iaug/yMVpKmhjQTgxci3+utPuiG3b3mx0V2GD/f38bpM2oOnv9K0EXo2LHL
 TmMeWILolfztYdJj7FcCcuZT7F/T+A+L2XsHp5n3EeFgDw7YqS1q0kthMNTwrh3V2fByAnMmJ
 j/F0qGIARg/ZVAOBm4e0aHuuCpMlms4TM8OGwvYReDQBEMhXZtsEPT5zUd0ReB2MHpHO71POo
 mOwCJ6FlzxRbizIPeVVclaNuV0NER5UxQLdtV1bdSJilGAnIBsP/dC7YEhLARlngThq4+dwGL
 hMbNAGwnegDPNcKipEE3uyO7xn9acQS+BLqay5twpQNhtYBRj6g3woIL6B8W6o+Xdnw66sbjT
 /BQNQT/kA1mo5CdLJANvDGzPgXnSYSa7nPtTPG8AzE8nPdUUAAwGe9kLu0aqHtYEi8RqYACAH
 SJCvhDc1qvcBLoZ1KVCz+rbJsX2TM5z7/yhtqWHTT4/y8UsQwPeJndMUJQhFYyh0YpbOeOzSu
 lU3DqqIbQzU4U3RY1wFJ+AQHYphSZXqf/DMcuXal0i+LqBP4aJ4pRvWhEcAPVzX4JUpMgUlqN
 eLSlj58hvRByIxUfdRBgYx7nhD72rCBUSKoO5G25lstGvTTYYMFqY4IKM5hFDagLM8F8RzELK
 ZolBwSg==

> >
>
> I am not an expert in amdgpu or gtt_mgr, but I wonder if some of the del=
etes are coming
> from forceful eviction  of memory during allocation?
>
> Have you filed a bug report for the nokaslr case?
>
> Balbir Singh

I did some more monitoring and in the BAD case ttm_global_swapout() is cal=
led
585 times leading to 54495 calls to ttm_bo_swapout_cb() while in the GOOD =
both
function are called 0 times.

Bert Karwatzki

