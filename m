Return-Path: <linux-kernel+bounces-263307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D3493D41D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C617EB2451F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BA217C211;
	Fri, 26 Jul 2024 13:22:20 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4BC17A5AB;
	Fri, 26 Jul 2024 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000140; cv=none; b=HHRAUrwuyucbHItLHeHYmcX2efodYRdPBbrF4vxIQz6pX/HdRVhzaGwucygzFe2MWA9KDfWRY+9QtX11E2ZTAknfB/w+9u+q77q7gPAejO99vV5Mz+RqyZQeg448tAivsu+wT7vVXAQGh+Q6g+awFQBBtRRvLjRc2SN2w4gxI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000140; c=relaxed/simple;
	bh=4/jwUnuQ2/kRKPBSUfZUz10HI2nO5dLvMyeeTsfBX3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFeTAAgW9AtJLandDVOaL1YdHCqyyjH9wjZmHoxIDGBSDfDmEHz+DNuqBcWjZwTP/eMUdnA5JQIY5pWvQxoXrl0sQTME805HIVJhCgHZ8mTPzkXUnSe6denZE5ASUjqBZAQuWPExAZwV/FbwwJcJGfLLVSkSzlpkyRgTiODh/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrABHp2zZoqNmJTkGAg--.61806S2;
	Fri, 26 Jul 2024 21:21:29 +0800 (CST)
Received: from [10.12.168.59] (unknown [10.12.168.59])
	by gateway (Coremail) with SMTP id _____wCntXjSoqNm9Nd2AA--.64248S2;
	Fri, 26 Jul 2024 21:21:25 +0800 (CST)
Message-ID: <e80ef726-fc2a-4bbf-b61f-d1419179eda6@hust.edu.cn>
Date: Fri, 26 Jul 2024 21:21:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/zh_CN: update the translation of security-bugs
To: Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>, Hu Haowen <2023002089@link.tyut.edu.cn>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240611020514.48770-1-dzm91@hust.edu.cn>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20240611020514.48770-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrABHp2zZoqNmJTkGAg--.61806S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvAXoWfJF15WFWUJFyrWr45tFW5KFg_yoW8GFW7Jo
	ZIyw43CwsFkrnrXr4rCw4UArW7Cr1fCFsavr4Iqwn8uw12gF4Fkw1Yyw1Yq3yS9ry5Wwn3
	JFyIgw4rJr45A3W5n29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOg7k0a2IF6FyUM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
	0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
	IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw2
	8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jDkucUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

ping?

On 2024/6/11 10:04, Dongliang Mu wrote:
> Update to commit 5928d411557e ("Documentation: Document the Linux Kernel
> CVE process")
>
> commit 0217f3944aeb ("Documentation: security-bugs.rst: linux-distros
> relaxed their rules")
> commit 3c1897ae4b6b ("Documentation: security-bugs.rst: clarify CVE
> handling")
> commit 4fee0915e649 ("Documentation: security-bugs.rst: update
> preferences when dealing with the linux-distros group")
> commit 44ac5abac86b ("Documentation/security-bugs: move from admin-guide/
> to process/")
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v2->v3: revise the references in zh_TW
> v1->v2: remove admin-guide/security-bugs, and revise all its references
>   .../translations/zh_CN/admin-guide/index.rst  |  1 -
>   .../zh_CN/admin-guide/reporting-issues.rst    |  4 +-
>   .../translations/zh_CN/process/index.rst      |  3 +-
>   .../security-bugs.rst                         | 42 ++++++++++++-------
>   .../zh_CN/process/submitting-patches.rst      |  2 +-
>   .../zh_TW/admin-guide/reporting-issues.rst    |  4 +-
>   .../zh_TW/process/submitting-patches.rst      |  2 +-
>   7 files changed, 34 insertions(+), 24 deletions(-)
>   rename Documentation/translations/zh_CN/{admin-guide => process}/security-bugs.rst (57%)
>
> diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
> index ac2960da33e6..773c53956000 100644
> --- a/Documentation/translations/zh_CN/admin-guide/index.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/index.rst
> @@ -37,7 +37,6 @@ Todolist:
>   
>      reporting-issues
>      reporting-regressions
> -   security-bugs
>      bug-hunting
>      bug-bisect
>      tainted-kernels
> diff --git a/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst b/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst
> index 59e51e3539b4..9ff4ba94391d 100644
> --- a/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst
> @@ -300,7 +300,7 @@ Documentation/admin-guide/reporting-regressions.rst 对此进行了更详细的
>   添加到回归跟踪列表中，以确保它不会被忽略。
>   
>   什么是安全问题留给您自己判断。在继续之前，请考虑阅读
> -Documentation/translations/zh_CN/admin-guide/security-bugs.rst ，
> +Documentation/translations/zh_CN/process/security-bugs.rst ，
>   因为它提供了如何最恰当地处理安全问题的额外细节。
>   
>   当发生了完全无法接受的糟糕事情时，此问题就是一个“非常严重的问题”。例如，
> @@ -983,7 +983,7 @@ Documentation/admin-guide/reporting-regressions.rst ；它还提供了大量其
>   报告，请将报告的文本转发到这些地址；但请在报告的顶部加上注释，表明您提交了
>   报告，并附上工单链接。
>   
> -更多信息请参见 Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
> +更多信息请参见 Documentation/translations/zh_CN/process/security-bugs.rst 。
>   
>   
>   发布报告后的责任
> diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
> index 5c6c8ccdd50d..011dc2cf583a 100644
> --- a/Documentation/translations/zh_CN/process/index.rst
> +++ b/Documentation/translations/zh_CN/process/index.rst
> @@ -49,10 +49,11 @@ TODOLIST:
>   
>      embargoed-hardware-issues
>      cve
> +   security-bugs
>   
>   TODOLIST:
>   
> -* security-bugs
> +* handling-regressions
>   
>   其它大多数开发人员感兴趣的社区指南：
>   
> diff --git a/Documentation/translations/zh_CN/admin-guide/security-bugs.rst b/Documentation/translations/zh_CN/process/security-bugs.rst
> similarity index 57%
> rename from Documentation/translations/zh_CN/admin-guide/security-bugs.rst
> rename to Documentation/translations/zh_CN/process/security-bugs.rst
> index d6b8f8a4e7f6..a8f5fcbfadc9 100644
> --- a/Documentation/translations/zh_CN/admin-guide/security-bugs.rst
> +++ b/Documentation/translations/zh_CN/process/security-bugs.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
>   .. include:: ../disclaimer-zh_CN.rst
>   
>   :Original: :doc:`../../../process/security-bugs`
> @@ -5,6 +7,7 @@
>   :译者:
>   
>    吴想成 Wu XiangCheng <bobwxc@email.cn>
> + 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
>   
>   安全缺陷
>   =========
> @@ -17,13 +20,13 @@ Linux内核开发人员非常重视安全性。因此我们想知道何时发现
>   
>   可以通过电子邮件<security@kernel.org>联系Linux内核安全团队。这是一个安全人员
>   的私有列表，他们将帮助验证错误报告并开发和发布修复程序。如果您已经有了一个
> -修复，请将其包含在您的报告中，这样可以大大加快进程。安全团队可能会从区域维护
> +修复，请将其包含在您的报告中，这样可以大大加快处理进程。安全团队可能会从区域维护
>   人员那里获得额外的帮助，以理解和修复安全漏洞。
>   
>   与任何缺陷一样，提供的信息越多，诊断和修复就越容易。如果您不清楚哪些信息有用，
>   请查看“Documentation/translations/zh_CN/admin-guide/reporting-issues.rst”中
> -概述的步骤。任何利用漏洞的攻击代码都非常有用，未经报告者同意不会对外发布，除
> -非已经公开。
> +概述的步骤。任何利用漏洞的攻击代码都非常有用，未经报告者同意不会对外发布，
> +除非已经公开。
>   
>   请尽可能发送无附件的纯文本电子邮件。如果所有的细节都藏在附件里，那么就很难对
>   一个复杂的问题进行上下文引用的讨论。把它想象成一个
> @@ -49,24 +52,31 @@ Linux内核开发人员非常重视安全性。因此我们想知道何时发现
>   换句话说，我们唯一感兴趣的是修复缺陷。提交给安全列表的所有其他资料以及对报告
>   的任何后续讨论，即使在解除限制之后，也将永久保密。
>   
> -协调
> -------
> +与其他团队协调
> +--------------
> +
> +虽然内核安全团队仅关注修复漏洞，但还有其他组织关注修复发行版上的安全问题以及协调
> +操作系统厂商的漏洞披露。协调通常由 "linux-distros" 邮件列表处理，而披露则由
> +公共 "oss-security" 邮件列表进行。两者紧密关联且被展示在 linux-distros 维基：
> +<https://oss-security.openwall.org/wiki/mailing-lists/distros>
> +
> +请注意，这三个列表的各自政策和规则是不同的，因为它们追求不同的目标。内核安全团队
> +与其他团队之间的协调很困难，因为对于内核安全团队，保密期（即最大允许天数）是从补丁
> +可用时开始，而 "linux-distros" 则从首次发布到列表时开始计算，无论是否存在补丁。
>   
> -对敏感缺陷（例如那些可能导致权限提升的缺陷）的修复可能需要与私有邮件列表
> -<linux-distros@vs.openwall.org>进行协调，以便分发供应商做好准备，在公开披露
> -上游补丁时发布一个已修复的内核。发行版将需要一些时间来测试建议的补丁，通常
> -会要求至少几天的限制，而供应商更新发布更倾向于周二至周四。若合适，安全团队
> -可以协助这种协调，或者报告者可以从一开始就包括linux发行版。在这种情况下，请
> -记住在电子邮件主题行前面加上“[vs]”，如linux发行版wiki中所述：
> -<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>。
> +因此，内核安全团队强烈建议，作为一位潜在安全问题的报告者，在受影响代码的维护者
> +接受补丁之前，且在您阅读上述发行版维基页面并完全理解联系 "linux-distros"
> +邮件列表会对您和内核社区施加的要求之前，不要联系 "linux-distros" 邮件列表。
> +这也意味着通常情况下不要同时抄送两个邮件列表，除非在协调时有已接受但尚未合并的补丁。
> +换句话说，在补丁被接受之前，不要抄送 "linux-distros"；在修复程序被合并之后，
> +不要抄送内核安全团队。
>   
>   CVE分配
>   --------
>   
> -安全团队通常不分配CVE，我们也不需要它们来进行报告或修复，因为这会使过程不必
> -要的复杂化，并可能耽误缺陷处理。如果报告者希望在公开披露之前分配一个CVE编号，
> -他们需要联系上述的私有linux-distros列表。当在提供补丁之前已有这样的CVE编号时，
> -如报告者愿意，最好在提交消息中提及它。
> +安全团队不分配 CVE，同时我们也不需要 CVE 来报告或修复漏洞，因为这会使过程不必要
> +的复杂化，并可能延误漏洞处理。如果报告者希望为确认的问题分配一个 CVE 编号，
> +可以联系 :doc:`内核 CVE 分配团队 <../process/cve>` 获取。
>   
>   保密协议
>   ---------
> diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
> index 7864107e60a8..7ca16bda3709 100644
> --- a/Documentation/translations/zh_CN/process/submitting-patches.rst
> +++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
> @@ -208,7 +208,7 @@ torvalds@linux-foundation.org 。他收到的邮件很多，所以一般来说
>   如果您有修复可利用安全漏洞的补丁，请将该补丁发送到 security@kernel.org 。对于
>   严重的bug，可以考虑短期禁令以允许分销商（有时间）向用户发布补丁；在这种情况下，
>   显然不应将补丁发送到任何公共列表。
> -参见 Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
> +参见 Documentation/translations/zh_CN/process/security-bugs.rst 。
>   
>   修复已发布内核中严重错误的补丁程序应该抄送给稳定版维护人员，方法是把以下列行
>   放进补丁的签准区（注意，不是电子邮件收件人）::
> diff --git a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
> index bc132b25f2ae..1d4e4c7a6750 100644
> --- a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
> +++ b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
> @@ -301,7 +301,7 @@ Documentation/admin-guide/reporting-regressions.rst 對此進行了更詳細的
>   添加到迴歸跟蹤列表中，以確保它不會被忽略。
>   
>   什麼是安全問題留給您自己判斷。在繼續之前，請考慮閱讀
> -Documentation/translations/zh_CN/admin-guide/security-bugs.rst ，
> +Documentation/translations/zh_CN/process/security-bugs.rst ，
>   因爲它提供瞭如何最恰當地處理安全問題的額外細節。
>   
>   當發生了完全無法接受的糟糕事情時，此問題就是一個“非常嚴重的問題”。例如，
> @@ -984,7 +984,7 @@ Documentation/admin-guide/reporting-regressions.rst ；它還提供了大量其
>   報告，請將報告的文本轉發到這些地址；但請在報告的頂部加上註釋，表明您提交了
>   報告，並附上工單鏈接。
>   
> -更多信息請參見 Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
> +更多信息請參見 Documentation/translations/zh_CN/process/security-bugs.rst 。
>   
>   
>   發佈報告後的責任
> diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
> index f12f2f193f85..64de92c07906 100644
> --- a/Documentation/translations/zh_TW/process/submitting-patches.rst
> +++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
> @@ -209,7 +209,7 @@ torvalds@linux-foundation.org 。他收到的郵件很多，所以一般來說
>   如果您有修復可利用安全漏洞的補丁，請將該補丁發送到 security@kernel.org 。對於
>   嚴重的bug，可以考慮短期禁令以允許分銷商（有時間）向用戶發佈補丁；在這種情況下，
>   顯然不應將補丁發送到任何公共列表。
> -參見 Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
> +參見 Documentation/translations/zh_CN/process/security-bugs.rst 。
>   
>   修復已發佈內核中嚴重錯誤的補丁程序應該抄送給穩定版維護人員，方法是把以下列行
>   放進補丁的籤準區（注意，不是電子郵件收件人）::


