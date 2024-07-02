Return-Path: <linux-kernel+bounces-238103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A999B92439A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CFB289775
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCCA1BD4E9;
	Tue,  2 Jul 2024 16:29:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CB1BD02F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937774; cv=none; b=pJs0zX+B4dEI1X+GmxNLy0eSkzfdEgwk6gBS3mxEadhcbyv0N8KRy+RlhwUZUULCMGD9tu7CZ6RbfESN0UtNUpAPinDJGxGLQ6SgFHZEfGKoCTqBPIUrc80Dj0a7FFGdLiyzwVxqliXWS0Y3VKM86UVZ3pfmNbwnv2tTA1CnvYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937774; c=relaxed/simple;
	bh=gqk2vFh9Auk5SXUL/7NTggb88FsoT6V+qwsLQy+zQC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDLIOy/9mleD3/GpYB0DTRjuUNZ294OrQVTGGgHWx88yrUY3ARrbfGp0L8WuiXS4DeLKUZPkRz/RYemmwWYOLRdiaEsR3lplVtz03UYNlfnC+akrTM2Wg47SZipPSpE4ceBqtu1LeZHZguROtwPTXSjul90UjhbMDsM6yH8cgkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB21C116B1;
	Tue,  2 Jul 2024 16:29:33 +0000 (UTC)
Date: Tue, 2 Jul 2024 12:29:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?5byg5YWD54Ca?= Tio Zhang <tiozhang@didiglobal.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, "mhiramat@kernel.org"
 <mhiramat@kernel.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "zyhtheonly@gmail.com"
 <zyhtheonly@gmail.com>, "zyhtheonly@yeah.net" <zyhtheonly@yeah.net>
Subject: Re: [PATCH 1/1] tracing/sched: sched_switch: place prev_comm and
 next_comm in right order
Message-ID: <20240702122931.4b6679af@rorschach.local.home>
In-Reply-To: <024001B4-3995-4B45-8724-536E02D2BD1A@didiglobal.com>
References: <14898c69-6a2e-4a9d-a0d4-d674087cd1ae@linux.ibm.com>
	<024001B4-3995-4B45-8724-536E02D2BD1A@didiglobal.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jul 2024 07:14:33 +0000
=E5=BC=A0=E5=85=83=E7=80=9A Tio Zhang <tiozhang@didiglobal.com> wrote:

> Hi Steven,=20
>=20
> Ping :)=20

If you want me to take this, please resend it and add
linux-trace-kernel@vger.kernel.org to the Cc so that my patchwork can
pick it up.

Also add anyone's tags to it as well.

-- Steve

