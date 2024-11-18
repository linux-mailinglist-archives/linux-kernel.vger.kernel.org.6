Return-Path: <linux-kernel+bounces-413020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B99D1289
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7ECFB25D98
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748E1AA1D9;
	Mon, 18 Nov 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FcJ1Tbvx"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EEC19AD7E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937294; cv=none; b=kUKYJZ3Ee2oJibJqR/JLUEF63XNJwZ3Ef66PYugHal7ppCKqKRs355njhmQY5vggpRPlCwayw1n8bCVBOaO8R99SwVRMFOFmX8yzOy7b3WxGUETnCAdUtrjBN6NA3F7nsxoSfNvqTm4EGFRDo0gfkWIKbJTDHkA2lnKuabTa3Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937294; c=relaxed/simple;
	bh=N+wkVNWq5O5wqzLl+pe4K8hwXpV5Z++skWgMkbBTPdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTzf29nVSRCnqAZKy9CPfUYfTbo+JzAPjURn6LbZwXgKEqp0J7Qw7Tq4rm91vA2YmvKSkNojUQEVg+rVFhit+vteKB2K1sk8Lp3Fz6F9TuBZcB9i+Ov7PtlBSyEzafNdsVo7druO/MvOHbmfp4RnmfVCyKDE0A6iOi1wsgNXTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FcJ1Tbvx; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 190701BF20B;
	Mon, 18 Nov 2024 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731937290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+wkVNWq5O5wqzLl+pe4K8hwXpV5Z++skWgMkbBTPdY=;
	b=FcJ1Tbvx995+nm4Hf5K1dmWYQSQI878Nyq9P4vfpNDuOCKkmMJRGz5d7LAzmv2Sb2iAUtK
	vbOeCuOe6v8bDRqSfym/opNgDhr+O7NNbmFUequCU6w0o6hC9UPHNSZWz/zRnAIaFtIx/v
	86ui4y806Xy/pM1eP+GJ8HxeFq1pgkQSMFHXygV/ohQywBb5n4TC8rJNyBtyqNaBnP5VWW
	iCa194ABW9gnRPaN4q5JG6o9FbDVJA/YB1IR2iJ5TkFDuE+i54pkxld9Prmh5HV/LjCJK5
	+N9itm0frh+Fks/mQwR23dA5JJFLIag3/ddEe0EwuabKol0HkCKT0H7VmjlALQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Oetken, Andreas" <andreas.oetken@siemens-energy.com>
Cc: Andreas Oetken <ennoerlangen@gmail.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mtd: core/part: trying to delete partition with
 usecount > 0 corrupt partition
In-Reply-To: <FR0P281MB1626159D92BE16A35E8272BAAE272@FR0P281MB1626.DEUP281.PROD.OUTLOOK.COM>
	(Andreas Oetken's message of "Mon, 18 Nov 2024 12:03:18 +0000")
References: <20241115085516.1852668-1-andreas.oetken@siemens-energy.com>
	<87ldxg26hn.fsf@bootlin.com>
	<FR0P281MB1626159D92BE16A35E8272BAAE272@FR0P281MB1626.DEUP281.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 14:41:29 +0100
Message-ID: <87mshwwtfa.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Andreas,

On 18/11/2024 at 12:03:18 GMT, "Oetken, Andreas" <andreas.oetken@siemens-en=
ergy.com> wrote:

> Hi Miqu=C3=A8l,
>
> Thanks for reviewing. You are right. The issue was already fixed with 19b=
fa9eb.=20
> I had the issue with v5.10.x.
> Sorry for submitting the patch in a hurry without rebasing and
> checking if it's already fixed.

No problem. You can however submit your patch to stable@ if you want to
fix this in 5.10.

Also, mind you have a double \n\n somewhere which will have to be fixed.

Cheers,
Miqu=C3=A8l

