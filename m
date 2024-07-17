Return-Path: <linux-kernel+bounces-255347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B80933F81
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3569E1C23277
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DFB181CFE;
	Wed, 17 Jul 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI+yp77i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2A18132E;
	Wed, 17 Jul 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229789; cv=none; b=YJ/0Ob0FJTQtN7qty5UtMMCrV3Lt8sXutdMqRGYHgI3HtdhUy6sUxaxNTbwAAnUdSqumrxhj/t00ry7+m5vlK5ZWNfDq3z48mDnPYKjivxqDB1zxVcae13CvqKfDqNsAHa1HDiKybtsTQ93qHnbsHGuZHyUn2eHp/7uhhBns5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229789; c=relaxed/simple;
	bh=wd5ue2q5X/0KfaDVS/3lLaW7JQLW7TKCUC4mIMuEV08=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Yn7zKNS0L6nDCkXeB5SzP0Ejb72IEXBr6HdGalQzNbChQcb5hpV+RQlj/JLrB56hwUefkxuJzULRcuIU2bPK356YX71JlKUkVRJt8QNNvupm6oDLCClJ75Pcn6nLlRXoVP0m/d+Ah14KS1JOvmfJPCBo154m8LhiuDPVY/6ZuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI+yp77i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA494C2BD10;
	Wed, 17 Jul 2024 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721229788;
	bh=wd5ue2q5X/0KfaDVS/3lLaW7JQLW7TKCUC4mIMuEV08=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FI+yp77iY9H+51Hr6HqYYDeNaqmEtO7kEpZPpnZ7Lpk70l/tBJVsMDM8DFADjommy
	 NmGUy/tiALUci7ayhMzFKFPNegEGEtC6VEkHXkVM/i5ovgy1aEj2p1z4KiBlILUhiN
	 M3bDAjusyLBNbexg9+4t6r6Zc2MK0cckqgVN51gqKM58Da7D9WjfF2QTg7bEn8Te83
	 T3Dc7UmK+mcMgpN9ZZ6xkk2GN4W1DNndTeaqP2KsuUq+xET1MtXnujtn5uxVAhCp4k
	 8nnhK7OWr4gUyoV/lVPxN/yoM+WG2hOocojZvkqswC0bsrxIdBTeJB3h1toj8BDwp2
	 dKiTu/8t+8W+A==
Message-ID: <7f9bac8c6f4b6e3434be34b0c09574e5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3fbab686-5a66-4b4e-b640-55426b2e1f57@quicinc.com>
References: <20240609-md-drivers-spmi-v1-1-f1d5b24e7a66@quicinc.com> <88ab18bd-0700-46c6-9d74-5bd79a1f0fc1@quicinc.com> <3fbab686-5a66-4b4e-b640-55426b2e1f57@quicinc.com>
Subject: Re: [PATCH] spmi: add missing MODULE_DESCRIPTION() macros
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Wed, 17 Jul 2024 08:23:06 -0700
User-Agent: alot/0.10

Quoting Jeff Johnson (2024-07-11 11:09:23)
>=20
> I still don't see this in linux-next.
> Adding Greg KH since seems he's been merging this driver.
> My hope is to have these warnings fixed tree-wide in 6.11.

I can pick it up or Greg can do so directly. I don't have anything in
the spmi queue and I was away from my computer for a few weeks so I
missed this one.

