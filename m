Return-Path: <linux-kernel+bounces-560442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF651A6044C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3B78814A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FA31F7075;
	Thu, 13 Mar 2025 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="fqmtFbDz"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572F1F6696
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904897; cv=none; b=LACiF3r5wWXdfpS7rBzaoR7/I9KUnfpPmnepJdldnwnZerE+Hrrl/EgfggS5bAMfWUjZMpsOw3FZLUS+yjz3QSC93357x3CkUPgIlB2qqux74JF5XlABupZCfmEODun6+bEo/G5JVgCNCuSu2hd1kBaVCQOzdxjey5pGiVIhrbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904897; c=relaxed/simple;
	bh=UZHfDSu598HqL1JYZaRqo0hyksFnTWQ90LTcyrIig0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=goISHR0Ge+ush7OZ/vEoRa1de3CRuCpqcRXThSua7DdnEayGGAFidkTUTtLm9QPL6fVZuhPU2nkInf7quk19hRWbSjPulRVtvv5eb2HW3ofritq6XVtyra/FG2OX24yKCzp1Fk/OFsntbxP0P994zWegUgOTICXArol4T2NNqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=fqmtFbDz; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741904873; x=1742509673; i=spasswolf@web.de;
	bh=UZHfDSu598HqL1JYZaRqo0hyksFnTWQ90LTcyrIig0s=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fqmtFbDzh6r1wVFhsafKuJ5bVrCw3fr1Wvk/SR0LsS6EyNeLoHkR1UrpRu7hUvS7
	 VE8zsEwK/U/fBegCdYUrcB/7glY6ltwQc2b9zELwGAF8vLMI2RIESNHcI0152mAyT
	 5++g/eo7Y0W2phnifk8+M65UDzRPNXY578R5DFTfdJ9+IN8x8jGs14DLNMhBigRa+
	 28PjvFrQDFfz0/Qj1dComJ+XkfFP7VVLLfMdbd3JuYFNgA+3eBVCZD62W0z5WgktH
	 IKQRNT1XX0/Oa81m3BFRL5GAcHUfL/SdhgPknT4yD2idTxkvre8TCbsLJWMwOpdOJ
	 r2MmyRLqTArvQSMQgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sc1-1tt8Bc3Si7-00G8ss; Thu, 13
 Mar 2025 23:22:07 +0100
Message-ID: <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, spasswolf@web.de
Date: Thu, 13 Mar 2025 23:22:06 +0100
In-Reply-To: <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
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
	 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
	 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rj5ELexmLntZ+I/BKImxJ2NUsGXQQm8Hq6gR1qO/SPDNeJg8NQ9
 sHM7ffS84LkVEazHXNw2DXtrNrE/Jc/dDttLUOzVz16AToVD8PIJCDZKv7QsOfCpPM4mntg
 cy1yODf++W8vlKldAEhrdFtb0St5LQ+gbKqFJ5Gr9LZ0ZQ+MviyhOznAH8rrgHy1iB7qvlT
 h0/KwB6q8qzqv41j7F4/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xs21HzjfLmM=;srPHX5ZTK5pbj7nQhCTd1pIwZYb
 H8mzmkoMrmUAVJ2IucF0Om4GxF+jABv9DT4QsiLAJbliq97Cn2nutVCN8TBCf6BbYIYbOM0gI
 BLuh/4dtGKI6KSUbMjq1igd7fI61bZQ8GILXah8zmB6DkH0slXZGKysRZe6eYEGFN72r5Wdf+
 wuJPcOC/oZL9QzLq7fgrKBekg6T+YA7dv/ItlVqtwaAT+uVnK+JAann/yeOWr7K3HCG/VN8yN
 hKj1WC99XYlBR0beXUu+TDpZ+hRa+jvlAtPeb36nE2Dx823sSJs7o15UJlNBoBKgAtRCW5HWf
 Y1WVdosi8fffWvwqoVqlgk6ZnISolZV8sN5cymUopKIwJtJg0usvZyUCMbLOSZgPDcqiv1nMP
 F3VNSbPmrgSrIfHbw0BFjIyT4Cd1T95HmXzLMpnW4LCVIv/TolbiKfv36eVGqC//CfJouRO/V
 jfGGf8ccNCsrx6wy5PPtCLlH7DCcUVKpQt4cDHhsn6G9wdEmEkyNQDRDL7odTgMd8nIEMQi2w
 zyPUvKdyxaELlb4SUzYtRG+9qgdymg+cYT+kNgxZ8dnSee03zjvo/P9Y7TzSgrweTE68xGuDF
 m9KQ1lw/Xiohq7urlKf+JWv4XkTVktHOR2y/znjP6Fx4uhVha3kNxk3X5izjtA9nm0+2ALxtY
 MZ6lELoyDm7XQ0MlH6537WnHzMWAbgBKLrWm3MCvN0FFJxvlmTJrWK44U2rUObaxjwh2wVWyZ
 RIqwVd41VbZokImOI8qGcvuFN5keyti5oTF0c5KYHz3mmqQYs54BGHMZOc+nbwzzAl5HxOiGu
 Zi8A/jPHQHju8ALnAVReesv+OLFPr1c4yULwRxAGKga3NGt7EkDANyjBNbFB/z8IB9EeiGRuz
 zyilGRnooU0p/wvThFV5+6WISG2p8tAbFi3MBjaQ8YzoktcldDSUdr8Kb5WfPZMZs9q4vOTgQ
 Y6GRhhAREpe93e0aUMJBoP1AD+5j0Ue/eX/Dbo4a0uieoBSrLnT+1TorDS4LFUQHTMvaMj3Cz
 A7Yx26OkVuhB1cPEOj/JFt8JOhQ2loX2MLDJNgdE9U6atycMOhcMU2sZ9GNgTI1mGb12LFeeT
 c1Y8iP0upjCO1HqrysxvvHCCV72izW38hO4PM1V94AupL6dX+HQqnKscijfveARwiRVTSOZrn
 pT/UWOgvAuVDyTg5QOsTds+/iVgY7FOElMHr2uqfUNUHOfJ5GeJ4zoZODCPhsdEtj9/S57Sea
 FMzOgkC8mFGHfTNQdjSQNn8s5kPfrdvTzE5R1dbVZaLnsnMDiINpzPsxeNX63dKGjgfTRFXaP
 K+Sl8M1zqgnG5ZVb36EgmH/5deDEQOnw4Euzb5jXKiY2XQrlCteIDTrGJl2FzSWgvBuXtYfIR
 BQqpQUmyOHUxLJR6Q5cYOe9iVOg4hUGfXghSkgrFskG5keTxaz4AwEFuskjZMNlne9bBuBSgX
 Opv5UhQv8xdZVgEY66KYi9mYCtx8=

Am Freitag, dem 14.03.2025 um 08:54 +1100 schrieb Balbir Singh:
> On 3/14/25 05:12, Bert Karwatzki wrote:
> > Am Donnerstag, dem 13.03.2025 um 22:47 +1100 schrieb Balbir Singh:
> > >
> > >
> > > Anyway, I think the nokaslr result is interesting, it seems like wit=
h nokaslr
> > > even the older kernels have problems with the game
> > >
> > > Could you confirm if with nokaslr
> > >
> > Now I've tested kernel 6.8.12 with nokaslr
> >
> > > 1. Only one single game stellaris is not working?
> > > 2. The entire laptop does not work?
> > > 3. Laptop works and other games work? Just one game is not working a=
s
> > expected?
> >
> >
> > Stellaris is showing the input lag and the entire graphical user inter=
face shows
> > the same input lag as long as stellaris is running.
> > Civilization 6 shows the same input lag as stellaris, probably even wo=
rse.
> > Magic the Gathering: Arena (with wine) works normally.
> > Valheim also works normally.
> > Crusader Kings 2 works normally
> > Rogue Heroes: Ruins of Tasos (a Zelda lookalike) works normally.
> > Baldur's Gate I & II and Icewind Dale work normally.
> >
> > Also the input lag is only in the GUI, if I switch to a text console (=
ctrl + alt
> > + Fn), input works normally even while the affected games are running.
> >
> > Games aside everything else (e.g. compiling kernels) seems to work wit=
h nokaslr.
> >
>
> Would it be fair to assume that anything Xorg/Wayland is working fine
> when the game is not running, even with nokaslr?
>
Yes, Xorg (I'm normally using xfce4 as desktop) works fine. I also tested =
with
gnome using Xwayland, here the buggy behaviour also exists, with the addti=
on
that mouse position is off, i.e. to click a button in the game you have to=
 click
somewhat above it.

> +amd-gfx@lists.freedesktop.org to see if there are known issues with
> nokaslr and the games you mentioned.
>
>
> Balbir Singh
>
> PS: I came across an interesting link
> https://www.alex-ionescu.com/behind-windows-x64s-44-bit-memory-addressin=
g-limit/
>
> I think SLIST_HEADER is used by wine as well for user space and I am not=
 sure
> if in this situation the game is hitting this scenario, but surprisingly=
 the other
> games are not. This is assuming the game uses wine. I am not sure it's r=
elated,
> but the 44 bits caught my attention.

Stellaris is a native linux game (x86_64), the one game (MTGA) I tested wi=
th
wine worked fine.

By the way, the warning
[ T8562] WARNING: CPU: 14 PID: 8562 at mm/slub.c:5028
__kvmalloc_node_noprof+0x2fd/0x360
that appeared in the dmesg I sent you is caused by the upgrade of mesa fro=
m
25.0.0 to 25.0.1. (I'm still bisecting ...)

Bert Karwatzki

