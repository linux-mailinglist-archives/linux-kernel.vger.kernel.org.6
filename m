Return-Path: <linux-kernel+bounces-512095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27773A333F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC991888D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BC027456;
	Thu, 13 Feb 2025 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ffe5/fVd"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A44A29;
	Thu, 13 Feb 2025 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406335; cv=none; b=GJ9yis8LgadAyQ4pWYEWKM4V0mfRce5TjZFlNmH5henTrYXanWPvUK+ncV5jEqobbpLubHrJaVbnCjSVKJIWv0Td1SKKe8YAF8D7XsVWguoi9hCSe0J4DGHY9exAG9yTY7gzyLo8QZg5ZdqbZHUSskNBdSs3Pv3O/o618mwjpeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406335; c=relaxed/simple;
	bh=/mMC9qm0+Vl0uwd0+1LavG/Aikmcvdnbmr+fUHIwL/U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oj2wEku0Fs+S13014Z1WDJCHdttXHAiX9MQMlDuXddDEgFaMHwGh7WQoIL3NdQjJ5kWaknMdW+oOqCyqOaoBao/F+KC/v7zBAl3NcxuvSd8JfpO5ru5XzLqpyXxe5L863JmT3oQhwT34KRfAJ6f1P3ttm6DblIN2wX0eplJvx4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ffe5/fVd; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739406331;
	bh=/mMC9qm0+Vl0uwd0+1LavG/Aikmcvdnbmr+fUHIwL/U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ffe5/fVdezqIZZvy9MisTNaxaYIRRrnOH7EpxbtHMGgRprWW3OUVD7hrEUKWRd84F
	 aFN2Hfpd8dKq+kIyrDH6xVajfpDkwhQNkGMHcdvRe+SDek3r16jPUonSQTAU1MZJmE
	 Sg7aii55lQa3/2HYDTfQtFhL6qsL8WteF7j73UfkBDAIvSukdsVFu65IKLLZjcl6oj
	 uClq2BZG0gDFPnyCCMfHvEiUN2wFq/8NY7+1Dzmd5oEiSGAbLUeI18u3vyAlE03GQH
	 cDnsMSJFZk+XUxVtUts9PwStbgyRbqYJa0XJPqtZGYP6wR3RmdrS6CMEN4zKSokCvo
	 rnG2Cy6SEv+ng==
Received: from [192.168.68.112] (203-173-7-184.dyn.iinet.net.au [203.173.7.184])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B701E7576E;
	Thu, 13 Feb 2025 08:25:30 +0800 (AWST)
Message-ID: <27d51c2c498cc5921998829e5279bf136d10f2dc.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ir38060: Move & update dt
 binding
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Guenter Roeck <linux@roeck-us.net>, Conor Dooley <conor@kernel.org>, 
	Naresh Solanki <naresh.solanki@9elements.com>
Cc: broonie@kernel.org, Jean Delvare <jdelvare@suse.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 13 Feb 2025 10:55:29 +1030
In-Reply-To: <c8dc4bdc-5374-4648-8092-55687be85f12@roeck-us.net>
References: <20250204180306.2755444-1-naresh.solanki@9elements.com>
	 <20250204-mulled-evaluate-8a690cdfbd4d@spud>
	 <CABqG17jHKfwJEfZxto_YA4opS8=QwqTqfNdkku8kcEv2_iW+XA@mail.gmail.com>
	 <20250205-purge-debating-21273d3b0f40@spud>
	 <CABqG17j4tKXnMZ5=vcjBvfe6JwCLQ6NbkQmJC9ySK_bmGEv=iQ@mail.gmail.com>
	 <20250206-camera-mashed-48cf0cf1715f@spud>
	 <4619661d7375c71710a22520f6ebbf353a5aff59.camel@codeconstruct.com.au>
	 <c8dc4bdc-5374-4648-8092-55687be85f12@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Guenter,

On Wed, 2025-02-12 at 06:46 -0800, Guenter Roeck wrote:
> Hi Andrew,
>=20
> On 2/12/25 02:43, Andrew Jeffery wrote:
> [ ... ]
> > The history of the problem from what I can see looks like:
> >=20
> > =C2=A0=C2=A0=C2=A0 1. pmbus regulator support exploiting "regulators" a=
s an OF
> > child
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node was merged for 3.19[1]
>=20
> I hope you mean "make full use of and derive benefit from (a
> resource)"
> and not "use (a situation or person) in an unfair or selfish way".

Certainly "make full use of and derive benefit from (a
resource)" and nothing further.

> If you think it is not appropriate for PMBus devices to register as
> regulators, please let me know, and feel free to suggest a better
> solution.

My only intent was to observe the history of the problem highlighted by
Naresh's patch. I don't have any concerns about PMBus devices
registering as regulators.

Thanks,

Andrew

