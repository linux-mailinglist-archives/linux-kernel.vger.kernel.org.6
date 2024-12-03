Return-Path: <linux-kernel+bounces-430292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A1C9E2EDB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AAF2839DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6460920ADD8;
	Tue,  3 Dec 2024 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRdKaUCv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4E205AAF;
	Tue,  3 Dec 2024 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263910; cv=none; b=JfMAO0raxb/xAmyDpcn7nq9J6sOB9b5pJUlUBro+lC6AWKoyzQb4CRrMXwXWtjJmFYpZcOeHJbGQIzhcM5Vu4g7E2d2zznd5vMao06eRqXvzYbteCoiF4nIxigkOMcrS30qnH+IvxCHgbrvcEAHQ00BqQBr9WmWJ9pIHojIDS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263910; c=relaxed/simple;
	bh=6h6lY5dhctPXg8GEk7u+mmIkbNWk3nfxv+MJY28mXFA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=cXu6lwAF4oe77gU1BV8ofmbbzDNtacLCUN4rDkVMJdNz2PyHJ/6mLytjQs2MDaBMZ4Win287Z3oV9aFh5+mzEdaSyqYNOs8D7EWNxZoRYP+6mF+R9nGqkDZnkw0ttkuOzK46m40DjXLZfSBQd9BZZbOSk4XSmaeEVe4acc1UcJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRdKaUCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35079C4CEDC;
	Tue,  3 Dec 2024 22:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733263910;
	bh=6h6lY5dhctPXg8GEk7u+mmIkbNWk3nfxv+MJY28mXFA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=pRdKaUCvZQrV/C0+mEaQcZLGiOY9mWaoVbTHA4ni1ETTkNxmidhbG9QNMYlTeJsFs
	 9in5Hw1feqfoMXUsNCXgXV9ySpZ/H507DFnvWHvnRx4G0KhHDssrgTAdogotqf2t5u
	 1qBWAqMcDsQuZuvJmraE54ONtns5tikARkCfsAnFIYgH+//J5XFtADc3QwYbwD4Fnm
	 vxXZMcKgG9D/y0b21On/3AOillF1lVu3Uq3RGPnJnM3aNWtdKxTPF+l7OMd59P3JCJ
	 GYtKsYHopRdPFPfuRHDXztrfE3OdlBNypdA9tKalh51GWzwQ38PlLbmNCxUA9UpQAO
	 yLpYUpWe1K3mA==
Message-ID: <f59843385d8e491eb1695741141b8a2b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241118192526.44180-2-ziyao@disroot.org>
References: <20241118192526.44180-2-ziyao@disroot.org>
Subject: Re: [PATCH] docs: clk: describe userspace debugging facilities
From: Stephen Boyd <sboyd@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Yao Zi <ziyao@disroot.org>
Date: Tue, 03 Dec 2024 14:11:48 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Yao Zi (2024-11-18 11:25:27)
> Starting from commit
> 03111b1088f1 ("clk: Add support for enabling/disabling clocks from debugf=
s"),
> it's possible to operate clocks from userspace through debugfs for
> testing purpose. This feature isn't provided as a Kconfig but rather a
> macro in source for security consideration, thus is hard to find.
>=20
> Let's document the macro to ease everyone's life of clock debugging.

Thanks for the patch. I don't want to advertise this anymore than it
already is though so let's skip this patch.

