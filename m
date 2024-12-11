Return-Path: <linux-kernel+bounces-441183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4354E9ECABA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB2A286318
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE14205E06;
	Wed, 11 Dec 2024 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="cHwV7RnE"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C10239BC5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914607; cv=pass; b=DslGlhLyK2NrFElrz3Vr8edLEtQeELKwINs0sUkJ9XA4kENpHLoNlp8L3AL4Mmo1FgG8eN+A5ozTrl1xumVmZn4s67t1u1HxDlRwYwTnP7KoxoPLYSJFHYp4WAKsiriOA1hrO91Hya+4djC0DJZUIDmcMYQehpfJn167DmlIR4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914607; c=relaxed/simple;
	bh=W+/SN7K2KMixQCup3rcdAyfoBVm70uy+MsYbVE+q0J8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tKWkzsZdPBx6B9RmMa3PlO+2uYOsYQc8nro9uR7ygoHDoCYRx3iRAtnyfyLkxnaoZugG05W2ldHUB+Dk+7m9B+wgEVldP4yUTBqI/f4J0htg3E7TqZVLLQt2OGlORf9S3D6896HIO5KsFTTLDCznPP8DqPS84VaW4zNC/v15MQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b=cHwV7RnE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733914588; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kWcitlYX9wPGloSNF+rZESmnJeOR2nE2StADKJOdjz8/fkE0nne6nwjU7MkUzM/8lrXEaf/B875UXjGjdtPYgqol1K+8VrDTVjh+U6Ez1kUVippkJ7ksBKAosRJ9RaLW209V5n0RHckzSoZYjs1xqFfAl9R2FGlIJdQxvYd2EAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733914588; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FKnFdXZWAoBv/d8UWrt27sHCfO2R5Hao/R8eFd2z2AY=; 
	b=Yauo+l77epXx9yj51v/WbdD/bB1UgIbI3pNAzSpWtUs8fEZs5ZbJ248PmRQzh0SiBBVhnmYNTWonEhSEUF69HouaTkM7WnBbsIR78f3Ar/aJToi0A4e8El9+QAC+emoTqy7ZdOLQJa8FDA/Mvm8c95eDArzk7e4iAfK/TqzHLPw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733914588;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FKnFdXZWAoBv/d8UWrt27sHCfO2R5Hao/R8eFd2z2AY=;
	b=cHwV7RnEPJm0hB0UrAZyg8kYtGs4BYem81K7qMz/rUvsFKZC4n7kMFZBpPcNFrEW
	EadqeAZ0VL0WMJ6kpx3hQuRZO5+abB7exQ/LEjQPq5G3s4jf5VzcJYTxpBv45Hwi/d/
	PS1x9uWa+eaClaVVzgDzGclnz9xcS1X+wdX+txNk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1733914556908829.5911025945064; Wed, 11 Dec 2024 02:55:56 -0800 (PST)
Date: Wed, 11 Dec 2024 10:55:56 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Pawel Anikiel" <panikiel@google.com>, "axboe" <axboe@kernel.dk>,
	"hch" <hch@lst.de>, "kernel" <kernel@collabora.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"sagi" <sagi@grimberg.me>
Message-ID: <193b55c7998.d66e7e7c1942154.6474606603462169748@collabora.com>
In-Reply-To: <Z1i0d5Ht8zUHhSu-@kbusch-mbp.dhcp.thefacebook.com>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com>
 <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
 <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
 <1932b818328.ad02576784895.6204301822664878956@collabora.com>
 <Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com>
 <193ab67e768.1047ccb051074383.2860231262134590879@collabora.com>
 <CAM5zL5pvxrpWEdskp=8xNuUM+1npJkVLCUTZh3hCYTeHrCR5ZA@mail.gmail.com> <Z1i0d5Ht8zUHhSu-@kbusch-mbp.dhcp.thefacebook.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail






 ---- On Tue, 10 Dec 2024 21:36:55 +0000  Keith Busch  wrote ---=20
 > On Mon, Dec 09, 2024 at 04:33:01PM +0100, Pawe=C5=82 Anikiel wrote:
 > > On Mon, Dec 9, 2024 at 1:33=E2=80=AFPM Robert Beckett bob.beckett@coll=
abora.com> wrote:
 > > > [...]
 > > > I have no further updates on this. I have received no further info f=
rom the vendor.
 > > > I think we can go ahead and use the alignment patch as is. The only =
outstanding question was whether it is an
 > > > implicit last entry per page chain vs simple alisngment requirement.=
 Either way, using the dmapool
 > > > alignment fixes both of these potential causes, so we should just ta=
ke it as is.
 > > > If we ever get any better info and can do a more specific patch in f=
uture, we can rework it then.
 > >=20
 > > I think the 512 byte alignment fix is good. I tried coming up with
 > > something more specific, but everything I could think of was either
 > > too complicated or artificial.
 > >=20
 > > Regarding the question of whether this is an alignment requirement or
 > > the last PRP entry issue, I strongly believe it's the latter. I have a
 > > piece of code that clearly demonstrates the hardware bug when run on a
 > > device with the nvme bridge. I would really appreciate it if this was
 > > verified and my explanation was included in the patch.
 >=20
 > I've pushed this to nvme-6.13 with an updated commit message here:
 >=20
 >   https://git.infradead.org/?p=3Dnvme.git;a=3Dcommitdiff;h=3Dccd84b8d6f4=
a60626dacb933b5d56dadca75c0ca

lgtm. Thanks!

 >=20
 > I can force an update if you have any edit suggestions.
 >=20
 > Commit message copied below:
 >=20
 > Author: Robert Beckett bob.beckett@collabora.com>
 >=20
 > nvme-pci: 512 byte aligned dma pool segment quirk
 >=20
 > We initially introduced a quick fix limiting the queue depth to 1 as
 > experimentation showed that it fixed data corruption on 64GB steamdecks.
 >=20
 > Further experimentation revealed corruption only happens when the last
 > PRP data element aligns to the end of the page boundary. The device
 > appears to treat this as a PRP chain to a new list instead of the data
 > element that it actually is. This is an implementation is in violation
 > of the spec. Encountering this errata with the Linux driver requires the
 > host request a 128k transfer and coincidently get the last small pool
 > dma buffer within a page.
 >=20
 > The QD1 quirk effectly works around this because the last data PRP
 > always was at a 248 byte offset from the page start, so it never
 > appeared at the end of the page. Further, the MDTS is also small enough
 > that the "large" prp pool can hold enough PRP elements to never get to
 > the end, so that pool is not a problem either.
 >=20
 > Introduce a new quirk to ensure the small pool is always aligned such
 > that the last PRP element can't appear a the end of the page. This comes
 > at the expense of wasting 256 bytes per small pool page allocated.
 >=20
 > Link: https://lore.kernel.org/linux-nvme/20241113043151.GA20077@lst.de/T=
/#u
 > Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")
 > Cc: Pawe=C5=82 Anikiel panikiel@google.com>
 > Signed-off-by: Robert Beckett bob.beckett@collabora.com>
 > Signed-off-by: Keith Busch kbusch@kernel.org>
 >=20


