Return-Path: <linux-kernel+bounces-373559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0589A9A58D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0CD1C21060
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAC317C9B;
	Mon, 21 Oct 2024 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sfFPVkXw"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3BE12B93
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729477400; cv=none; b=MTFHlwf3bp1OHsywDxpvrWQZH3U7ONfS17BM5fbgMt4/5VOyDzEUA6F6HnfPH7WFOT+cCP2ZEpXLbVoMlObXYNyeBe6Zvl1YePmBZDLZbaP5AvxzvUMX1nsjYAK5NBzpWnCpD0a2XgpPydGWKwE4O0uqlNCs0G0KWdBoCP8vMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729477400; c=relaxed/simple;
	bh=8YaLhFa3jny6vw8aAJQ4SYVgKkm1ICP9Pf0Qx0UAoIw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=UPAfYJOwfRYZTnP3aK4yu4DKLPEU3LbWYMsu8hdlcfkA7YLrGbI0hEdFgWjX9ZNsAyFUmaqBD6NPr1LBl10qM3A5WeLePmoXUpekwvmCpSAz+136n+JGDNH11Z2vz3RyTnBa/2dB0t2FSMXS0OElKbptQE7wgZY154b7Z+T0oCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sfFPVkXw; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729477392; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YHT6vg/+2MSt8QxyhBRwiFWAVKo3U+sWohVAUGnEi8=;
	b=sfFPVkXw5Wni23pmFokSbnb8Ahq1t4siCBdT54B/ldyzvYCskGROiKrbiSDgDIOCn9Z9DP
	YK9ZrkrFxXRbKIciW7EXtMdZ0xkGuuLaD7iJ7uzUF5lB2V8XT7OAt8FGR6vnDAknVF4b+B
	n7tm5H9VjToYLiXs3S04d2wrIGLKTIk=
Date: Mon, 21 Oct 2024 02:23:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <7af6a933e6b7e2e4bb18b049870860bf84fd77b0@linux.dev>
Reply-To: lenbotkin@zohomail.eu
TLS-Required: No
Subject: Re: [PATCH v3 net-next] net: vlan: Use vlan_prio instead of vlan_qos
 in mapping
To: "Ido Schimmel" <idosch@idosch.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZxT3oVQ27erIoTVz@shredder.mtl.com>
References: <20241018141233.2568-1-yajun.deng@linux.dev>
 <ZxT3oVQ27erIoTVz@shredder.mtl.com>
X-Migadu-Flow: FLOW_OUT

October 20, 2024 at 8:29 PM, "Ido Schimmel" <idosch@idosch.org> wrote:



>=20
>=20On Fri, Oct 18, 2024 at 10:12:33PM +0800, Yajun Deng wrote:
>=20
>=20>=20
>=20> The vlan_qos member is used to save the vlan qos, but we only save =
the
> >=20
>=20>  priority. Also, we will get the priority in vlan netlink and proc.
> >=20
>=20>  We can just save the vlan priority using vlan_prio, so we can use =
vlan_prio
> >=20
>=20>  to get the priority directly.
> >=20
>=20>=20=20
>=20>=20
>=20>  For flexibility, we introduced vlan_dev_get_egress_priority() help=
er
> >=20
>=20>  function. After this patch, we will call vlan_dev_get_egress_prior=
ity()
> >=20
>=20>  instead of vlan_dev_get_egress_qos_mask() in irdma.ko and rdma_cm.=
ko.
> >=20
>=20>  Because we don't need the shift and mask operations anymore.
> >=20
>=20>=20=20
>=20>=20
>=20>  There is no functional changes.
> >=20
>=20
> Not sure I understand the motivation.
>=20
>=20IIUC, currently, struct vlan_priority_tci_mapping::vlan_qos is shifte=
d
>=20
>=20and masked in the control path (vlan_dev_set_egress_priority) so that
>=20
>=20these calculations would not need to be performed in the data path wh=
ere
>=20
>=20the VLAN header is constructed (vlan_dev_hard_header /
>=20
>=20vlan_dev_hard_start_xmit).
>=20
>=20This patch seems to move these calculations to the data path so that
>=20
>=20they would not need to be performed in the control path when dumping =
the
>=20
>=20priority mapping via netlink / proc.
>=20

Yes,=20you're right about that. But there's another case.=20
Not=20all callers need to get the vlan qos, but some callers need to get =
the
vlan priority (get_vlan_ndev_tc/irdma_iw_get_vlan_prio/irdma_roce_get_vla=
n_prio)
in irdma.ko and rdma_cm.ko.
These callers and vlan_dev_set_egress_priority are opposite operations.
If we use vlan_prio, we can save these two opposite operations.


> Why is it a good trade-off?
>

