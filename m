Return-Path: <linux-kernel+bounces-275839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E133948ADE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19435288534
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231DF166F25;
	Tue,  6 Aug 2024 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="j2Q75+53"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD528F5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931543; cv=none; b=EDto5U268tq1xeU5V9G2teurCNe8SVExXhNL3+mTJgBGoQg+ZLKBITfq5qh2WzDWADLCBm1FbKT6qGLqYrB7Y3Oar5Wusv3PCEI77q2HRyt5umKFzpYOS/IQx5EikmZuzpohtpWvgDk4XnL2o2XItBW12V8lzSCVWMP9jpSHVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931543; c=relaxed/simple;
	bh=JvBlAEYgusWTj0QaWz9xN+asB1hck3mH8iVJh7BgJpg=;
	h=Message-ID:Date:MIME-Version:Cc:References:Subject:From:To:
	 In-Reply-To:Content-Type; b=u03cM0Z6Zk5haHwJfG5NgXBrXU1LH9RtO09SNmHX3VdZa+ZzL3hkpiH4kHuW3T+fE2x1KPgdSDLQ4gN1uesCDxeuQKNgGJhqP174OKCTNA9BgkHEfJQ1RZ4JoRShtBwkSqghZ426kSC29gXaIrMsfynWnwRJxs3IFXJOb/cEKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=j2Q75+53; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722931527; x=1723536327; i=markus.elfring@web.de;
	bh=JvBlAEYgusWTj0QaWz9xN+asB1hck3mH8iVJh7BgJpg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Cc:References:
	 Subject:From:To:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=j2Q75+53GKtD8ltL8v/rJUSVHt/xrnCbr1o4+fvy9xYoWUB0NeFVwQYdjEw1USz/
	 DFz1/6k50lKPnt1/Dr9QU4vZgIx+ZJFbVxRHZMDl4UZZ8o+fZHeyCcK3aBrdMJu9P
	 3UqgS6hsuuiQJ/pCE5PXJo/Ohj5r9pypfJimsPiOBdopvGP8MNSk5LW1jGHceUBNE
	 9RDwQxR+/4nrh++AJkXP87fe/GGa2p3ISy84WICpVh2B1sR9QZFanhe2c7VXtNtuE
	 7TXeWqlPWAywktR1aGJQ0bqGVDSujdhTqZApwjGT3v6hy8i3+fDTHOnyQXZgqmenZ
	 BR85+vO2iJFjTeoiKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLARU-1stKHE3sZ8-00RcDj; Tue, 06
 Aug 2024 10:05:26 +0200
Message-ID: <f66e2016-d2c8-4a86-9a6f-267770f7fed5@web.de>
Date: Tue, 6 Aug 2024 10:05:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: LKML <linux-kernel@vger.kernel.org>, George Yang <George.Yang@amd.com>,
 king.tam@amd.com, Max Zhen <max.zhen@amd.com>, Min Ma <min.ma@amd.com>,
 Narendra Gutta <VenkataNarendraKumar.Gutta@amd.com>,
 Sonal Santan <sonal.santan@amd.com>
References: <20240805173959.3181199-1-lizhi.hou@amd.com>
Subject: Re: [PATCH V2 00/10] AMD XDNA driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Lizhi Hou <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>
In-Reply-To: <20240805173959.3181199-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:40qaAv4KOPgJzTzTPF0s9ukKOy3mNK0F6i6IblVQTee0t5PBElZ
 G1Hsg2Ry/1dtEepcPkKutsPeaIfCf4ITz/3q1poI2Ro4gBTrYyJBkBLukBV/DWKdsdS8Y0C
 IpPTSxWc/Kur29nqGn8/PYzXFh5azRpGvCuKptYEoIBrA4Cx8RtINrXq35ME2EnhLa0YhED
 QExKQOpazQk9ThV3K+Xmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TQBqRqh8Cm0=;DkccvwdTmLkOGrwM5uN+WZjuOu2
 rBJr52d/2ivEotKuSLqfx4t7t2i7dfPJt9y4nfZyYKbJ71SuG53Va7e97wnMHNIBTNdgjbCK1
 /nc+5p0qK0XFV230+jB/xs/wBEnH/I/ErsBs5cNIwo1nqMyiMpHIu75d1fKlbzbq6HsEL6qHW
 lnIkgm4iRFTnPFSFk5J0X6+754/08epOE2KSrqZ6XLJE+lIPFobmIGNWuN4g9iRPmz7f81huX
 jEBkzpOuULBMqEwOUbuhYdjQ84GR+cqXplESuY/R0sXLZrUVB9f5X5N0Y0OeohG3g8CL8Kgig
 rL7ojDpwazJFhMd+YZ6Rpf4r777nXlIGe0Q75LLgD0Q+c7Pbf1RxjUZLySsdH006jI9rQ8Bg8
 AO5GB579onu1OVbO5ONxzHgBMNICiVm75vUuy1sqi1LFWEXJaUdSVZCxJMcf6Qm5K9yteY5W2
 YWbaMbKpsRo0ZxUBkS9hjUHfG2MvZs5q1S6EqOJ/4nRix3lyxYqdEEFmI00m2TSbie7JXEtpo
 nf21BDXsLmmpECplQjLrmtKZI1hlcfVkUZiE6oiBTXgXmDOVn/5UNRfUnhlHuup886OydCN8s
 y9WFca4xg9AP5w7nEIEBr0C7SqxT4XDsIt67cEEUhyniV9wUj+7dalnzy2Cd5IWZTfLc/BJuA
 vAomy5Lucb/o3ridfZRWK24sQ/GlQ1P+XliPjMVZeI9a+8h9g3ztvZ/QrSp0G9GFn9MazUeTn
 hNxLgyXJ3uRHXytOXLnH767oMLZqV8npy0UJpNKGQZOOMtz0L9FEtPLkXfTibJzIq1S0jxrNr
 6tcK5QoBkH+hCwhqggv+Rc7w==

=E2=80=A6
> Changes since v1:
> - Remove some inline defines
> - Minor changes based code review comments
=E2=80=A6

How =E2=80=9Cgood=E2=80=9D does such a version description fit to previous
patch review feedback (like the following)?

https://lkml.org/lkml/2024/7/19/803
https://lore.kernel.org/linux-kernel/010a46ba-9dc4-e3e3-7894-b28b312c6ab1@=
amd.com/
[01/10] accel/amdxdna: Add a new driver for AMD AI Engine
=E2=80=9Cguard looks cleaner. We will use it.=E2=80=9D


Can further adjustment suggestions be taken better into account?

Regards,
Markus

