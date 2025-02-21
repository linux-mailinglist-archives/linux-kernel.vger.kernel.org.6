Return-Path: <linux-kernel+bounces-525302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC26A3EDDC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55671895626
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B31FBCAD;
	Fri, 21 Feb 2025 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BureGQXz"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7E1D798E;
	Fri, 21 Feb 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125060; cv=none; b=cLM3hORSL5FTQgDLu7ZX12nEXHDWBZOnPYKkFL8NcruRyIZLiYsvsYDGfGYRjlOZElmnczhzqaXxIxGj6qwm9dVoALXEgB9K3c43koaaVg6A9jFP87ZKg66+5ITrZx4b0F3jUVdGtWFhGsW0llQk207A/CdQ+vMvaQf94UgwzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125060; c=relaxed/simple;
	bh=a+iB+6V2NB5xFg9ygOOMKy9Dnt7qDVIg5M/U+rLO9CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7iiU9d+OZ5V6AOoFMVdS97u3JjtUqUTejYzd73wQlsBldBujOqVTqDJeta9tBUq5r3gn5GprFN2dbktymHOSWOVxl0dy23VNo0EruJoGnYzCtBy3HM791twD+5XKu+6eBoiz8/B+qeEn4IGpLi/HZbOtbgTEoy5bEsUi5bOS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BureGQXz; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740125048; x=1740729848; i=markus.elfring@web.de;
	bh=a+iB+6V2NB5xFg9ygOOMKy9Dnt7qDVIg5M/U+rLO9CE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BureGQXzSGScc0QTj9c5JTA1Bv0QWOuTVlzQ5Hlf2xnilgz5BoNKlQcH83sGvpbS
	 1iC0Gn+3doGAINYiFpcybYhxcpCBJsgjl4KVh909Fg56nFPertU+W66tObniEiIGz
	 QYYkPkADgZ1GmpTrE+4x2G7OePoZWwuSxfDPenuk5EEva3FBOEyfT/xzPE3HtcLkf
	 Yf2rsbKeLbHEkBnmn0GiLcpUbJrcJc8+oQkKb7lKVnTWTgM3zuDiIOK8iLpszGbN1
	 ZUU/rY9r5H5+uO7/fmtN1rU5C3e3LHvDtr4dWQbU/Rd0HCkcxfeJH2VEGxHsg4rlH
	 YxAFmVIF0F7NXm6SQQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.4]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoeY7-1sx9sX0dXV-00e2bP; Fri, 21
 Feb 2025 09:04:08 +0100
Message-ID: <05f3fc66-f11d-4cda-8ea3-91aac650ec20@web.de>
Date: Fri, 21 Feb 2025 09:03:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched: fix potential use-after-free with cfs bandwidth
To: Josh Don <joshdon@google.com>, kernel-janitors@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ben Segall <bsegall@google.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Mel Gorman <mgorman@suse.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>
References: <20250221012335.233404-1-joshdon@google.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250221012335.233404-1-joshdon@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BG2sYxsze/PyI5uB/J0H76STggS63ytFxggW3Ax/pgQ+aFCirgX
 IisiqhGOJnJV8Mp0N/UwMJqlPBDBZTKxu9LiFEckEUszW4BrG0/P4zVvPrIjdGbzpKmm2Hj
 dHIOn2Kbg5F4HhbWgFST6sW8HHUpxZW0/q/VAhlxcQ1r3E9yvTYhoBIXdQoQIH7v3fPtEIM
 GFgmATuUSSBkMtZwbJIQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qc0EudHn7Ss=;5Z0dvCw+L89pDhS4iC0RD07RBn/
 gNUeoG6gWQYJswNbKFgPJWhzizM4AEQvW0POOmPvB+pD0pvlilyUnuTdhr/ZPah13nAdd+xlH
 q9cAJPx1jU1YKj9iwC80DzzckJ3OsWV1fimpu9CFPx8GeclrZ6ECQJbgBm5Mu978OFiajw6Df
 WD1BImvLMwCUjOndgLRvTESc7RnPQjWs2KUWvOS+AgziF2JLGg7JhG6EzUVJpTj8EMXGqNjnd
 yfKebhHZroY4ILS1uuK6K+ei08r6V5ld6pmMqN/S6x7OdGEb+//KGwCoY3HKeZld33Se9lBF3
 pehVL8U3c6Y9D0GV1LXmWMPbGodhRA2TbTAZGWRR6+s+0zwaxPE4w6VpL+gYIs+ZyoSQczLCe
 uW+lyb5it8TojZOpiK6l3ndk8Si0ji0OzpyZR53Kz0OOAlvi+9M6jDJG0/KSIrYmcXFXrvNCs
 1o/fOxFUttwL410eNGjmI2dsUoURYoN9pHmZOlfp+mk+NknjRLUtlK3RuHjPkutj9bdIVvvZq
 C3bXC5ya0lu+A1ew5RkU/l9OxzMZKDnKS+DRC/wElb2q3EukAT7XTftH1555QIlEQmUMM7yWv
 nkKmOONcCoFSX9BoreqJNjkOubBzR4H8vfjFWc2DH8Fnhk68SkBwUsvJNgWXLzGPe2z6YZqGj
 b0mumEOMvDEQDuI3ljEtD0vnvWGiu815A7bHf+5SQnnlbbdH5A2kPkWm2Xyf75y1y3TbjeLk4
 hzNMu0UlpkApPXv4sKA0a4vD8Y3+h6cxfdMSOUTnt3j+7yPrU3ItAFnSzTgBQ5K4UfCetfwt9
 we4vsTZ+OPkOAscjk6stq3CpgwHFkvJ8vdb0sJZKO5WvBHXqnXBsQMc814eG3/4FyfXvy7pzh
 uHcgAoN0ZBTMcEljdLqtCGrh+lZL/5tXeScPiHwJeL7KN0qy/Zs1oEqSQIVW7LpsloowJy9a1
 aDRHvsluy0psHgP6vLyKunILLfKckMTtMnYzzG/hFJcc0F104H+CcRkFJl3ZidG36O/O1F/lg
 fkn6knCaqj7R83aGo+r6zEfzGTynWvRlZgTxN9m4anUDQ64rHOJJ8+9wehL9Jv5cA3/Yzzk7a
 tbp0TVJYAclcwG1FH2gieOXrsLNcGE8ECosv0/9VNGXuvRR9G737F4lVQC6PaTOUsxzZb/tWU
 UEaqkaQwupIQokjt6kFETLh3VykCXZ/uEJabzLv3J1X0P0hNF+jfYzs2R2Zd+Dp9jljXVyHU3
 rYldGPtYdYWUXlWtCCcK3PXObRPbMdctWNg41yy4Eon5UCNpmxjM8/18ZHkXwmtldqSWA4Jau
 pE9xOVhaeXYcpR6jArKFowol5Byiy8qw0Ci64zIro+tnKxEtlKzePhAavPJ+pbSM+YjSzQux7
 4LMPabHId6Z1NIvs05+AHPDZgiRRCjrHyXLu0lrx1sOp87XKIP6qZxug2qNXiLWMjes+UKvQl
 tWmudOEejAfM9Bc6Knj5wH3Qa0A0=

=E2=80=A6
> For full correctness, we should avoid removal from the list until after
> we're done unthrottling in __cfsb_csd_unthrottle().
=E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc3#n94


=E2=80=A6
> Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
=E2=80=A6

Is such a tag really supported?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc3#n539

Regards,
Markus


