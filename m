Return-Path: <linux-kernel+bounces-218391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9562E90BDB8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F27282BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB0419924B;
	Mon, 17 Jun 2024 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qkrFsuIB"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD41D953B;
	Mon, 17 Jun 2024 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664043; cv=none; b=gwnH3d1IyRyIKBJ+T3OC6SW5KKLh+OcmdmP2FavxevePezaI7xcKfk1cUCMhNkNiXjJzfXX32F8SUtpqbpbkAW27ZwFOj1fdX6qVcWhil7bu/0V5U0ED6jfHXlbdwauBjr+tJU4CMBgfjDEnovUpkJamldgawG5KkUMFqzvDxsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664043; c=relaxed/simple;
	bh=Fsm9OuRh6Gn1a1tvsJrwCrl645RcmYLD128vIyx+Zj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BzvJ0aYhxjfy7wtUvNFfldgY7id21PvNVTGAaWzqhRfuRacqQ37mhBJ6DIXydqx6GNoxP2bph7/55if5wGnWq2Ff85vdzrJRt0tYBaRXiiN7X9GOOt6+qXlGBAZepFKgb2ZJrA42NwvRnx4aKR/L+uri6/OgA8kjcsu4PsUkduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qkrFsuIB; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B1AC445E08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718664040; bh=Fsm9OuRh6Gn1a1tvsJrwCrl645RcmYLD128vIyx+Zj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qkrFsuIB1uN12ulbDXHckHNFe2BrsLYkd7Q+hWBcu4eQYb0/E8OEPtotB0jcOUjRB
	 iykuX1gAiEbLklMRHmM97zx/jmqTGP6/mLito6eoavOs5YHqeOOz7nLYaVQOeagasC
	 a3Cmj+KkEOCzmeTVS0lNA+KDjBJ34Kx31GUa9mOpEhSOh5pwrfVPZZ0xXHz4mk+Sur
	 UMpDYzumNAB0B8Ns53RZ228Arag9apH/BnxoU0Qjt6KblgGCtkW1lnZAZ3pbqL9nqS
	 TLQA31jzMW+AHk66IkllR9hrYoaISFezEDpynKioLAIr+JcZVicM/F82k8DwCjWqwS
	 V5wlPClFf9jyw==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B1AC445E08;
	Mon, 17 Jun 2024 22:40:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: Update the translation of
 dev-tools/gdb-kernel-debugging
In-Reply-To: <20240612145048.57829-1-dzm91@hust.edu.cn>
References: <20240612145048.57829-1-dzm91@hust.edu.cn>
Date: Mon, 17 Jun 2024 16:40:39 -0600
Message-ID: <878qz3gplk.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

RG9uZ2xpYW5nIE11IDxkem05MUBodXN0LmVkdS5jbj4gd3JpdGVzOg0KDQo+IFVwZGF0ZSB0byBj
b21taXQgNmIyMTk0MzEwMzdiICgiZG9jcy9zY3JpcHRzL2dkYjogYWRkIG5lY2Vzc2FyeQ0KPiBt
YWtlIHNjcmlwdHNfZ2RiIHN0ZXAiKQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEb25nbGlhbmcgTXUg
PGR6bTkxQGh1c3QuZWR1LmNuPg0KPiAtLS0NCj4gIC4uLi90cmFuc2xhdGlvbnMvemhfQ04vZGV2
LXRvb2xzL2dkYi1rZXJuZWwtZGVidWdnaW5nLnJzdCAgICAgfCA0ICsrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
dHJhbnNsYXRpb25zL3poX0NOL2Rldi10b29scy9nZGIta2VybmVsLWRlYnVnZ2luZy5yc3QgYi9E
b2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9kZXYtdG9vbHMvZ2RiLWtlcm5lbC1kZWJ1
Z2dpbmcucnN0DQo+IGluZGV4IDE3YjVjZTg1YTkwYy4uOTRjMTVjMjU4NzI2IDEwMDY0NA0KPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9kZXYtdG9vbHMvZ2RiLWtlcm5l
bC1kZWJ1Z2dpbmcucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L2Rldi10b29scy9nZGIta2VybmVsLWRlYnVnZ2luZy5yc3QNCj4gQEAgLTM0LDYgKzM0LDEwIEBA
IEtnZGLlhoXmoLjosIPor5XlmajjgIFRRU1V562J6Jma5ouf5py6566h55CG56iL5bqP5oiW5Z+6
5LqOSlRBR+eahOehrOS7tuaOpeWPow0KPiAgICDkvYbov5npgJrluLjku4XlnKjkuI3kvp3otZbl
hoXmoLjmqKHlnZfml7bmiY3mnInmlYjjgILmnInlhbPmraTmqKHlvI/nmoTmm7TlpJror6bnu4bk
v6Hmga/vvIzor7flj4LpmIVRRU1V5paH5qGj44CCDQo+ICAgIOWcqOi/meenjeaDheWGteS4i++8
jOWmguaenOaetuaehOaUr+aMgUtBU0xS77yM5bqU6K+l5Zyo56aB55SoQ09ORklHX1JBTkRPTUla
RV9CQVNF55qE5oOF5Ya15LiL5p6E5bu65YaF5qC444CCDQo+ICANCj4gKy0g5p6E5bu6Z2Ri6ISa
5pys77yI6YCC55So5LqO5YaF5qC4djUuMeeJiOacrOWPiuS7peS4iu+8iQ0KPiArDQo+ICsgICAg
bWFrZSBzY3JpcHRzX2dkYiANCj4gKw0KDQpUaGlzIG9uZSBnYXZlIG1lIHRoZSBmb2xsb3dpbmcg
ZXJyb3I6DQoNCkFwcGx5aW5nOiBkb2NzL3poX0NOOiBVcGRhdGUgdGhlIHRyYW5zbGF0aW9uIG9m
IGRldi10b29scy9nZGIta2VybmVsLWRlYnVnZ2luZw0KLmdpdC9yZWJhc2UtYXBwbHkvcGF0Y2g6
MTU6IHRyYWlsaW5nIHdoaXRlc3BhY2UuDQogICAgbWFrZSBzY3JpcHRzX2dkYiANCndhcm5pbmc6
IDEgbGluZSBhZGRzIHdoaXRlc3BhY2UgZXJyb3JzLg0KDQpJIGZpeGVkIGl0IHRoaXMgdGltZSwg
YnV0IHBsZWFzZSB0cnkgdG8gYXZvaWQgYWRkaW5nIHRoaXMga2luZCBvZg0Kd2FybmluZyBpbiB0
aGUgZnV0dXJlLg0KDQpUaGFua3MsDQoNCmpvbg0K

