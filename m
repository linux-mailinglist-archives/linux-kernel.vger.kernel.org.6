Return-Path: <linux-kernel+bounces-356735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0CE9965F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C6D286012
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826FE18D640;
	Wed,  9 Oct 2024 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mQNccgmj"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C518B46B;
	Wed,  9 Oct 2024 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467570; cv=none; b=q+NdF2yW4gNSWD7gtyKyr6QHMYZZSe0YWvC1BVUYgvTcFtZZUJi1ahh0LZuZlSaN3L24rb88GEpv8kp4G94i7nFpvhVOuD+Pgh9d+fl++xYXlCLBhpImmVrS+q0NN7YzVch4LRxgBwUcgUuwSC5SEyKBoUe7CrftohRd9ZlnpBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467570; c=relaxed/simple;
	bh=b0ZbQneXmo6dvdqwYl843ohgOyb8+AdpviLApC1gU+g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CytNTPGz9VsmmzJh6RwK3NheZZVHSJHDotBViJbBeF71w7zg/GR1f1DR9HmgibpthCd9+cwTt5fRbVLeLz957g3NrtSMq5EmD13WCIAmkx5KLFHANaXuPixD771C/a7ehTDMgOLJtro1OA5ICn/xj0AJmtFJeY7hh0FzdIGgRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mQNccgmj; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728467541; x=1729072341; i=markus.elfring@web.de;
	bh=b0ZbQneXmo6dvdqwYl843ohgOyb8+AdpviLApC1gU+g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mQNccgmj+GGuMxY0hnCHZtsXw0MLprYAqGNGYzBtN6QpCxC95xN4jVOHeyEY26GP
	 V496DoB/OczRyFbWyUacA0vuOJBl7/5rtUB4+M7Ukedc8ecvWpYB6Yng6iCwUA4p2
	 f8SjLT25RLdzLf92fxVQLqafw+bowugIKs8AiQJtwuR29/h20El3B8XehQEIuYu1q
	 gY1m+KD8UMBKKrYq46ZoykWbdVJI92nNqkX3F9/cTqvClYg8WcxnV7TyCu6grx2a8
	 KFBCB0jl1hQfe6A1E5gS0zr5T9J3ZCygg3cCSTC3SkCckundJwn7N9wyP+DDhxF1E
	 nBXDOSXqaqNYQcNOEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkElP-1tj7vg09If-00k7Ko; Wed, 09
 Oct 2024 11:52:21 +0200
Message-ID: <36ec69a0-4412-497b-9efc-fe9e980059ed@web.de>
Date: Wed, 9 Oct 2024 11:52:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, linux-sound@vger.kernel.org,
 "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
References: <20241009092305.8570-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH v2] ALSA: scarlett2: Add error check after retrieving PEQ
 filter values
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241009092305.8570-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kwJKxbcCqTJXdcUoNSlif8Wg4Gd+7Xq/uXThOP/+wdPeTCN70+l
 +qku761SoPK6W8HjEOj810tWDJ9QcXbEQA3EG27KCkU5bMUnC25KlIqTas9PCZl23PH+rY5
 n03cMzhmY5w4sS+cM5PSsRDiIN6pE5UtP5M2kGBd/xPg7zg9UDmdOB9fMkeM0MPr/NGFCJu
 3ApFHGHMlh2rXGIkjAGmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rLOrM/0n6C0=;vDYcfc8q8mlJ+EFx7vGU6RrZF5j
 1baS06f2oKbS6Nip330vp/de6ZNvQxeXXwzrYxCD1jcn3tVW+ptlmYPplbVekzB5zDotahqK1
 CNtC7WKox7h3NuAQla88ur18uwnSHe67qFxob36WPo1viEfWU+1RySLKABD3tCqmZRVlw6clj
 nOIbA1nMOndh3CySrwqYswNdMcZrDUgLYbnOQJiqNlpEyt76VomlES7CnArbEKOQKZ9lNmfp8
 ZF+2rEtHzcb+UcF+fPo04I9j/vCQqcK6+PxAJKNPLWuhOHY+N09450nsurCNWKjkq4J5N/x+n
 0GrZedCmDr3gPS32JAqkTI6cH4MQnsrkEXQjjwCgRJjR5YKHxFdN3cSn5CTnjTsuzpdsP7Di5
 lkCLIxe5hKG1rHkdeHl9q+n70HUxvJVz979fBTbuGX1PykT+yKEUGJ/IgKpkcZB57WUllMvBR
 Vl8K7/+RjDfQeGQCUFFBTGCBGL89YMOA6JREXS7uOWcVfOa3gbXNlYeQLkmLldXg7Vh9E5FH6
 JkWaVyiEIO1noCG46peuwdYNjeOC9cqoZSsAELJGPFdpvg5ojfvhQHQB8kfUA20nEu/1MZ8K9
 SumNPz8xWjde03gVIyJT3VyqxIvJTSaCywJxl+u9F3Bdxs6B+qo/cKTukxgqB1EBlA0bpbF8l
 jJ2USnhg3MVa2u+NYuDhTkFZLTUA7NZ8g2vJKgBivjVVzZEcZ3fFqOOwUKg623wkX6YaRErEQ
 I3Aedqg/AcauO11aG1maemtOvtcGhcjIgcaqVR4w8LBC+V36XGzI3sw2jt5WPY4TimBQtoLpJ
 Uz4DRCH7U5SXA5g/DCoElzLg==

=E2=80=A6
> Cc: <stable@vger.kernel.org>

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n262


> ---
> V1 -> V2:
> - commit wit a dot

A dot was appended to a change description.


> - add tag "Cc"
=E2=80=A6

Do you expect that the tag =E2=80=9CFixes=E2=80=9D will be added by an oth=
er contributor finally?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n145

Regards,
Markus

